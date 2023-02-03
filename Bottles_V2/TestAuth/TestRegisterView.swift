//
//  RegisterView.swift
//  AuthTest
//
//  Created by 장다영 on 2023/02/02.
//

import SwiftUI

// TODO: - 이메일 인증 없이 회원가입 안되게
/// 지금 이메일 인증은 되지만 이메일로 링크 받고 인증 시, 다시 앱으로 돌아오기 안됨
/// 다시 앱으로 돌아오려면 dynamic link 사용해야하는데 개발자 계정 필요

struct TestRegisterView: View {
    @State private var userEmail = ""
    @State private var userPassword = ""
    @StateObject var auth: AuthStore
    
    var body: some View {
        TextField("이메일", text: $userEmail)
        Button("이메일 인증") {
            auth.emailCheck(userEmail: userEmail)
        }
        Text("이메일 인증 \(String(auth.isEmailVerified()))")
        TextField("비밀번호", text: $userPassword)
        Button("회원가입") {
            auth.registerUser(name: "", email: userEmail, password: userPassword)
        }.disabled(auth.isEmailVerified())
    }
}


