//
//  ContentView.swift
//  AuthTest
//
//  Created by 장다영 on 2023/02/02.
//

import SwiftUI

struct TestLoginView: View {
    @State private var email = ""
    @State private var password = ""
    @StateObject private var auth =  AuthStore()
    
    var body: some View {
        NavigationStack {
            VStack {
                //Text("현재 로그인 중: \(String(auth.isLogin))")
                TextField("이메일", text: $email)
                TextField("비밀번호", text: $password)
                
                Button("로그인") {
                    auth.login(email: email, password: password)
                }
                
                NavigationLink(destination: RegisterView(auth: auth)) {
                    Text("회원가입")
                }
                
                Button("로그아웃") {
                    auth.logout()
                }
            }
            .padding()
        }
        
    }
}

struct TestLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TestLoginView()
    }
}

