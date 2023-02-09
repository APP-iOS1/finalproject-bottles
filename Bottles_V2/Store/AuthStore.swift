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

class AuthStore: ObservableObject {
    
    @Published var currentUser: Firebase.User?
    @Published var isLogin = false
    @Published var loginError: Bool = false
    @Published var resetPassword: Bool = false
    @Published var emailVerification: Bool = false
    
    let database = Firestore.firestore()
    let userStore: UserStore = UserStore()
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    func login(email: String, password: String) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                self.loginError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.loginError = false
                }
                return
            } else {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.currentUser = result?.user
                    self.loginError = false
                    self.isLogin = true
                    print("로그인 성공")
                }
            }
            
        }
        
    }
    
    func logout() {
        currentUser = nil
        self.isLogin = false
        try? Auth.auth().signOut()
    }
    
    // MARK: - 계정 생성
    func registerUser(email: String, password: String, nickname: String, userPhoneNumber: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [self] result, error in
            if let error = error {
                print("Error : \(error.localizedDescription)")
                return
            }
            
            guard let authUser = result?.user else { return }
            currentUser = authUser
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
