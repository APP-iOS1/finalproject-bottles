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
            }
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.currentUser = result?.user
                self.loginError = false
                self.isLogin = true
                print("로그인 성공")
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
            userStore.createUser(user: User(id: UUID().uuidString, email: email, followItemList: [], followShopList: [], nickname: nickname, pickupItemList: [], recentlyItem: [], userPhoneNumber: userPhoneNumber))
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
        return ((Auth.auth().currentUser?.isEmailVerified) != nil)
    }
    
    // MARK: - Method : 계정 삭제
    func deleteUser() {
        let user = Auth.auth().currentUser
//        user?.delete { error in
//            if let error = error {
//                print("계정 삭제 실패")
//            } else {
//                // Account deleted
//            }
//        }
    }
    
    func sendPasswordReset(email: String) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                print("비밀번호 재설정 에러: \(error)")
                self.resetPassword = false
            } else {
                self.resetPassword = true
                print("메일 보내짐")
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
