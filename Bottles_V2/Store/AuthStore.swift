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

class AuthStore: ObservableObject {
    
    
    @Published var currentUser: Firebase.User?
    @Published var isLogin = false
    
    @Published var loginError: Bool = false
    @Published var resetPassword: Bool = false
    @Published var emailVerification: Bool = false
    
    let database = Firestore.firestore()
    let userStore: UserStore = UserStore()
    
    
    @Published var kakaoLoginError: Bool = false
    var errorSocialType: String = ""
    @Published var kakaoLogin: Bool = false
    
    
    @Published var googleLoginError: Bool = false
    
    init() {
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
            self.isLogin = true
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
            userStore.createUser(user: User(id: UUID().uuidString, email: email, followItemList: [], followShopList: [], nickname: nickname, pickupItemList: [], recentlyItem: [], userPhoneNumber: userPhoneNumber, deviceToken:UserStore.shared.fcmToken ?? ""))
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
                                    self.userStore.createUser(user: User(id: (user?.kakaoAccount?.email)!, email: (user?.kakaoAccount?.email)!, followItemList: [], followShopList: [], nickname: (user?.kakaoAccount?.profile?.nickname)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? ""))
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
                                            self.kakaoLoginError = true
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
                                self.currentUser = result?.user
                                self.userStore.createUser(user: User(id: (user?.profile?.email)!, email: (user?.profile?.email)!, followItemList: [], followShopList: [], nickname: (user?.profile?.name)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? ""))
                                
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
                                       
                                    }
                                    
                                }
                            } else {
                                GIDSignIn.sharedInstance.signOut()
                                self.errorSocialType = socialLoginType
                                self.googleLoginError = true
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
        } catch {
            print(error.localizedDescription)
        }
    }
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


