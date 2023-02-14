//
//  AuthStore.swift
//  AuthTest
//
//  Created by 장다영 on 2023/02/02.
//

import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
import GoogleSignIn
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import FBSDKLoginKit
import AuthenticationServices
import CryptoKit


enum LoginPlatform {
    case email
    case google
    case kakao
    case apple
    case facebook
    case none
}

class AuthStore: ObservableObject {
    
    @Published var loginPlatform: LoginPlatform = .none
    
    @Published var currentUser: Firebase.User?
    @Published var isLogin = false
    
    @Published var loginError: Bool = false
    @Published var resetPassword: Bool = false
    @Published var emailVerification: Bool = false
    
//    let database = Firestore.firestore()
    let userStore: UserStore = UserStore()
    
    
    var errorSocialType: String = ""
    @Published var kakaoLogin: Bool = false
    
    @Published var nonce: String = ""
    
    @Published var appleEmail: String = ""
    
    init() {
//        FirebaseApp.configure()
        currentUser = Auth.auth().currentUser
    }
    
    func authLogin(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self.loginError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.loginError = false
                }
                return
            } else {
                self.currentUser = result?.user
                self.loginError = false
                self.isLogin = true
               
            }
            
        }
    }
    func login(email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.currentUser = result.user
            self.loginPlatform = .email
        } catch {
            self.loginError = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                self.loginError = false
            }
        }
    }
    
    func logout() {
        currentUser = nil
        try? Auth.auth().signOut()
        self.isLogin = false
    }
    
    // MARK: - 계정 생성
    func registerUser(email: String, password: String, nickname: String, userPhoneNumber: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let authUser = result?.user else { return }
//            currentUser = authUser
            // 회원 가입시 해당 유저가 입력한 이메일로 인증 링크를 보내줌
            Auth.auth().currentUser?.sendEmailVerification{ error in
                if let error = error {
                    print("이메일 전송 실패: \(error.localizedDescription)")
                } else {
                    print("이메일 전송 완료")
                }
            }
            userStore.createUser(user: User(id: email, email: email, followItemList: [], followShopList: [], nickname: nickname, pickupItemList: [], recentlyItem: [], userPhoneNumber: userPhoneNumber, deviceToken:UserStore.shared.fcmToken ?? "", noticeList: [], socialLoginType: "이메일"))
            print("회원가입 완료")
            //let user: User = User(id: authUser.uid, name: name, email: email, temperature: 36.5, registDate: getStringDate(date: Date()),chatIDList: [])
            //FIXME: 여기에 addUser 함수 호출
            //userStore.addUser(user)
            
        }
    }
    
    func emailCheck(userEmail: String?) {
        guard let email = userEmail else { return }
        
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://bottlesv2.firebaseapp.com/?email=\(email)")
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        
        Auth.auth().sendSignInLink(toEmail: email,
                                   actionCodeSettings: actionCodeSettings) { error in
            if let error = error {
                print(error)
                print("email not sent \"\(error.localizedDescription)\"")
            } else {
                print("email sent")
            }
        }
    }
    
    func isEmailVerified() -> Bool {
        
        if Auth.auth().currentUser?.isEmailVerified == true{
            print("이메일 인증 성공: \(String(describing: Auth.auth().currentUser?.isEmailVerified))")
            return true
        } else if Auth.auth().currentUser?.isEmailVerified == false{
            print("이메일 인증 실패: \(String(describing: Auth.auth().currentUser?.isEmailVerified))")
            emailVerification = true
            return false
        } else {
            // 로그아웃 시에 currentUser의 이메일 인증을 확인하는 isEmailVerified이 nil이기 때문에 이미 한번 이메일 인증을 받고 로그인 성공한 계정은 바로 로그인 되게 해줌
            return true
        }
    }
    
    /// 이메일 인증을 했는지 currentUser의 isEmailVerified 값을 확인하기 위해 비동기 처리로 현재 currentUser의 email인증을 true인지 false인지 확인 해주는 함수
    func currentUserReload() async {
        do {
            try await Auth.auth().currentUser?.reload()
        }
        catch {
            print("Auth.auth().currentUser?.reload() error")
        }
    }
    
    // MARK: - Method : 계정 삭제
    func deleteUser(userEmail: String) {
        let user = Auth.auth().currentUser
        user?.delete { error in
            if let error = error {
                print("계정 삭제 실패: \(error.localizedDescription)")
            } else {
                self.userStore.deleteUser(userId: userEmail)
            }
        }
    }
    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("비밀번호 재설정 에러: \(error)")
                self.resetPassword = false
                self.loginError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.loginError = false
                }
            } else {
                print("메일 보내짐")
                self.resetPassword = true
            }
        }
    }
    
    //MARK: - 카카오 로그인
    @MainActor
    func handleKakaoLogin() async {
        // 카카오톡 설치 여부 확인 - 카카오톡이 설치가 되어있을 때
        
            if (UserApi.isKakaoTalkLoginAvailable()) {
                kakaoLogin = await loginWithKakaoApp()
            } else {
                // 카카톡이 설치가 되어 있지않을 때 카카오 웹뷰로 로그인
                kakaoLogin = await loginWithKakaoAccount()
            }
        
    }
    
    /// 카카오 앱을 통해 로그인
    private func loginWithKakaoApp() async -> Bool{
    
        await withCheckedContinuation{ continuation in
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoTalk() success.")
                    //TODO: FirebaseAuth에 심어야 함
                    //do something
                    if let oauthToken = oauthToken {
                        print("카카오톡: \(oauthToken)")
                        self.signUpInFirebase()
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    /// 카카오 앱이 없을 시 웹으로 띄워서 로그인
    private func loginWithKakaoAccount() async -> Bool{
        
        await withCheckedContinuation { continuation in
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //TODO: FirebaseAuth에 심어야 함
                    //do something
                    if let oauthToken = oauthToken {
                        print("카카오톡: \(oauthToken)")
                        self.signUpInFirebase()
                        continuation.resume(returning: true)
                    }
                }
            }
        }
    }
    
    func kakaoLogout() {
        Task {
            await handleKakaoLogout()
        }
    }
    
    func handleKakaoLogout() async -> Bool{
        await withCheckedContinuation{ continuation in
            UserApi.shared.logout { [self](error) in
                if let error = error {
                    print(error)
                    continuation.resume(returning: false)
                }
                else {
                    self.currentUser = nil
                    print("logout() success.")
                    continuation.resume(returning: true)
                }
            }
        }
    }
    
    // MARK: - 카카오톡 계정 파이어베이스 auth에 추가
    func signUpInFirebase() {
        let type = "카카오"
        UserApi.shared.me() { user, error in
            if let error = error {
                print("카카오톡 사용자 정보 가져오기 에러: \(error.localizedDescription)")
            } else {
                // 1, FireStore User 컬렉션 documentID == email 일치하는게 있는지 확인 = 기존 등록된 계정 있는지 확인
                // if 있으면 documentID 하위의 필드의 socialLoginType을 가져와 "카카오"와 type이 같은지 확인
                // 같으면 로그인
                // 다르면 dimiss 시키고, 알림으로 socialLoginType으로 로그인 하시라고 안내
                // 2. documentID == email 없으면 Auth 유저 생성 및 FireStore 유저 생성
                Firestore.firestore().collection("User").whereField("email", isEqualTo: (user?.kakaoAccount?.email)!)
                    .getDocuments { snapshot, error in
                        if snapshot!.documents.isEmpty {
                            // 회원가입으로 넘기는 부분
                            FirebaseAuth.Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                                print("email: \(String(describing: user?.kakaoAccount?.email))")
                                
                                print("userid: \(String(describing: user?.id))")
                                
                                if let error = error {
                                    print("에러 발생")
                                    
                                } else {
                                    self.currentUser = result?.user
                                    self.userStore.createUser(user: User(id: (user?.kakaoAccount?.email)!, email: (user?.kakaoAccount?.email)!, followItemList: [], followShopList: [], nickname: (user?.kakaoAccount?.profile?.nickname)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? "", noticeList: [], socialLoginType: type))

                                    self.loginPlatform = .kakao
                                    print("파이어베이스 사용자 생성 성공")
                                    
                                }
                                
                            }
                            
                            
                            
                        } else {
                            Firestore.firestore().collection("User").document((user?.kakaoAccount?.email)!).getDocument { (snapshot, error) in
                                
                                let currentData = snapshot!.data()
                                let email: String = currentData!["email"] as? String ?? ""
                                let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                                
                                if socialLoginType == type {
                                     //로그인 처리 (auth에 로그인 -> 뷰를 넘겨줌)
                                    Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                                        if let error = error {
                                            print("로그인 에러: \(error.localizedDescription)")
                                            return
                                        } else {
                                            self.currentUser = result?.user
                                            self.loginPlatform = .kakao
                                            print("카카오 파이어베이스 어스 로그인 성공")
                                            //  뷰 전환
                                        }

                                    }
                                    
                                } else {
                                    // 프로세스 종료 및 socialLoginType를 사용자에게 알려줌
                                    // 키카오 언링크 & 웹 끄기
                                    UserApi.shared.unlink {(error) in
                                        if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("unlink() success.")
                                            // MARK: 사용자에게 무언가 알려줘야 함
                                            self.errorSocialType = socialLoginType
                                            self.loginError = true
                                        }
                                    }
                                    // 뷰를 login뷰로 다시 넘겨주기 (따로 없어도 됨)
                                }
                            }
                            
                        }
                    }
                
            }
        }
    }
    
    // MARK: - 구글 로그인
    func googleSignIn(){
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                return
            }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            guard let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }
            
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
               
            }
            
        }
    
    }
    
    //MARK: - 구글 로그인 시 firebase Auth에 추가 및 데이터 베이스 추가
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        let type = "구글"
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        Firestore.firestore().collection("User").whereField("email", isEqualTo: (user?.profile?.email)!)
            .getDocuments { snapshot, error in
                if snapshot!.documents.isEmpty {
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
                            if let error = error {
                                print(error.localizedDescription)
                                print("로그인 실패")
                            } else {
                                self.loginPlatform = .google
                                self.currentUser = result?.user
                                self.userStore.createUser(user: User(id: (user?.profile?.email)!, email: (user?.profile?.email)!, followItemList: [], followShopList: [], nickname: (user?.profile?.name)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? "", noticeList: [], socialLoginType: type))
                                
                                
                                print("로그인 성공")
                            }
                        }
                    }
                } else {
                    Firestore.firestore().collection("User").document((user?.profile?.email)!)
                        .getDocument { snapshot, error in
                            
                            let currentData = snapshot!.data()
                            let email: String = currentData!["email"] as? String ?? ""
                            let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                            
                            if socialLoginType == type {
                                Auth.auth().signIn(with: credential) { result, error in
                                    if let error = error {
                                        print("구글 로그인 에러: \(error.localizedDescription)")
                                        return
                                    } else {
                                        self.currentUser = result?.user
                                        self.loginPlatform = .google
                                    }
                                    
                                }
                            } else {
                                GIDSignIn.sharedInstance.signOut()
                                self.errorSocialType = socialLoginType
                                self.loginError = true
                            }
                        }
                }
            
        }
    }
    
    func googleSignOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            currentUser = nil
            self.loginPlatform = .none
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - FacebookLogin
    var manager = LoginManager()
    
    func facebookLogin() {
        let type = "페이스북"
        manager.logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
            if let error = error {
                print("\(error.localizedDescription)")
            }
            if !result!.isCancelled {
                let request = GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email"])
                request.start{ _, res, _ in
                    guard let profileData = res as? [String: Any] else { return }
                    
                    let userName = profileData["name"] as! String
                    let userEmail = profileData["email"] as! String
                    
                    let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
                    Firestore.firestore().collection("User").whereField("email", isEqualTo: userEmail)
                        .getDocuments { snapshot, error in
                            if snapshot!.documents.isEmpty {
                                if let error = error {
                                    print("\(error.localizedDescription)")
                                } else {
                                    Auth.auth().signIn(with: credential){[unowned self] (result, error) in
                                        if let error = error {
                                            print(error.localizedDescription)
                                            print("로그인 실패")
                                        } else {
                                            self.currentUser = result?.user
                                            self.userStore.createUser(user: User(id: userEmail, email: userEmail, followItemList: [], followShopList: [], nickname: userName, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? "", noticeList: [], socialLoginType: type))

                                            self.loginPlatform = .facebook
                                            print("로그인 성공")
                                        }
                                    }
                                }
                            } else {
                                Firestore.firestore().collection("User").document(userEmail)
                                    .getDocument { snapshot, error in
                                        let currentData = snapshot!.data()
                                        let email: String = currentData!["email"] as? String ?? ""
                                        let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                                        if socialLoginType == type {
                                            Auth.auth().signIn(with: credential){ result, error in
                                                if let error = error {
                                                    print("페이스북 로그인 에러: \(error.localizedDescription)")
                                                } else {
                                                    self.currentUser = result?.user
                                                    self.loginPlatform = .facebook
                                                }
                                        
                                            }
                                        } else {
                                            self.manager.logOut()
                                            self.errorSocialType = socialLoginType
                                            self.loginError = true
                                        }
                                    }
                            }
                        }
                }
            }
        }
    }
    
    func facebookLogout() {
        manager.logOut()
        do {
            try Auth.auth().signOut()
            currentUser = nil
            self.loginPlatform = .none
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - 애플로그인
    
    
    
    func appleLogin(credential: ASAuthorizationAppleIDCredential) {
        
        guard let token = credential.identityToken else { return }
        
        guard let tokenString = String(data: token, encoding: .utf8) else { return }
        
        let firebaseCredential = OAuthProvider.credential(withProviderID: "apple.com", idToken: tokenString, rawNonce: nonce)
        
        let type = "애플"
        
        
        Auth.auth().signIn(with: firebaseCredential){[unowned self] result, error in
            if let error {
                print("\(error.localizedDescription)")
            }
            Firestore.firestore().collection("User").whereField("email", isEqualTo: result?.user.email)
                .getDocuments { snapshot, error in
                    if snapshot!.documents.isEmpty{
                        if let error = error {
                            print("\(error.localizedDescription)")
                        } else {
                            self.currentUser = result?.user
                            self.userStore.createUser(user: User(id: credential.email!, email: credential.email!, followItemList: [], followShopList: [], nickname: credential.email!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? "", noticeList: [], socialLoginType: type))

                            self.loginPlatform = .apple
                        }
                    } else {
                        Firestore.firestore().collection("User").document((result?.user.email)!)
                            .getDocument { snapshot, error in
                                let currentData = snapshot!.data()
                                let email: String = currentData!["email"] as? String ?? ""
                                let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                                
                                
                                print("socialLoginType: \(socialLoginType)")
                                if socialLoginType == type {
                                    self.currentUser = result?.user
                                    self.loginPlatform = .apple
                                    print("애플 로그인 currentUser: \(self.currentUser)")
                                } else {
                                    self.appleLogout()
                                    self.errorSocialType = socialLoginType
                                    self.loginError = true
                                }
                            }
                    }
                }
            
            
        }
        
//        Firestore.firestore().collection("User").whereField("email", isEqualTo: credential.email!)
//            .getDocuments { snapshot, error in
//                if snapshot!.documents.isEmpty {
//                    if let error = error {
//                        print("\(error.localizedDescription)")
//                    } else {
//                        Auth.auth().signIn(with: firebaseCredential) { result, error in
//                            if let error = error {
//                                print("애플 파이어베이스 로그인 에러 \(error.localizedDescription)")
//                            } else {
//                                self.currentUser = result?.user
//                                self.userStore.createUser(user: User(id: credential.email!, email: credential.email!, followItemList: [], followShopList: [], nickname: credential.email!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? ""))
//                            }
//                            
//                        }
//                    }
//                } else {
//                    Firestore.firestore().collection("User").document(credential.email!)
//                        .getDocument { snapshot, error in
//                            let currentData = snapshot!.data()
//                            let email: String = currentData!["email"] as? String ?? ""
//                            let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
//                            
//                            if socialLoginType == type {
//                                Auth.auth().signIn(with: firebaseCredential) { result, error in
//                                    if let error = error {
//                                        print("애플 파이어베이스 로그인 에러 \(error.localizedDescription)")
//                                    } else {
//                                        self.currentUser = result?.user
//                                    }
//                                }
//                            } else {
//                                self.appleLogout()
//                                self.errorSocialType = socialLoginType
//                                self.loginError = true
//                            }//TODO: 로그아웃 처리
//                        }
//                }
//            }
        
    }
    
    func appleLogout() {
        do{
            try Auth.auth().signOut()
            currentUser = nil
//            print("애플 로그인 currentUser: \(currentUser)")
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    func allLogout() {
        switch loginPlatform {
        case .email:
            self.logout()
        case .kakao:
            self.kakaoLogout()
        case .facebook:
            self.facebookLogout()
        case .google:
            self.googleSignOut()
        case .apple:
            self.appleLogout()
        case .none:
            self.appleLogout()
            print("로그아웃 실패")
        }
    }
}

//MARK: - 애플로그인시 뷰에서 필요한 메소드
func randomNonceString(length: Int = 32) -> String {
    precondition(length > 0)
    let charset: Array<Character> =
    Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
    var result = ""
    var remainingLength = length
    
    while remainingLength > 0 {
        let randoms: [UInt8] = (0 ..< 16).map { _ in
            var random: UInt8 = 0
            let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if errorCode != errSecSuccess {
                fatalError("Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)")
            }
            return random
        }
        
        randoms.forEach { random in
            if remainingLength == 0 {
                return
            }
            
            if random < charset.count {
                result.append(charset[Int(random)])
                remainingLength -= 1
            }
        }
    }
    
    return result
}

func sha256(_ input: String) -> String {
    let inputData = Data(input.utf8)
    let hashedData = SHA256.hash(data: inputData)
    let hashString = hashedData.compactMap {
        return String(format: "%02x", $0)
    }.joined()
    
    return hashString
}

extension AuthStore {
    func checkNameRule(name : String) -> Bool {
        let regExp = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{2,8}$"
        return name.range(of: regExp, options: .regularExpression) != nil
    }
    
    func checkEmailRule(email : String) -> Bool {
        let regExp = #"^[a-zA-Z0-9+-\_.]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"#
        return email.range(of: regExp, options: .regularExpression) != nil
    }
    
    func checkPasswordRule(password : String) -> Bool {
        let regExp = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,20}$"
        return password.range(of: regExp, options: .regularExpression) != nil
    }
    
    // MARK: -Method : Date 타입의 날짜를 받아서 지정 형식(데이터베이스 저장 형태) 문자열로 반환하는 함수
    func getStringDate(date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy-mm-dd HH:mm:ss"
        return dateFormatter.string(from: date)
    }
}


