//
//  LoginView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/30.
//

import SwiftUI

struct LoginView: View {
    
    @State private var loginEmail: String = ""
    @State private var loginPassword: String = ""
    var body: some View {
        NavigationStack {
            Spacer()
            Image("Image")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200)
            Spacer()
            
            VStack(spacing: 10){
                Button(action:{
                    
                }){
                    Text("카카오로 시작하기")
                }
                Button(action:{
                    
                }){
                    Text("페이스북로 시작하기")
                }
                Button(action:{
                    
                }){
                    Text("apple로 로그인")
                }
                Button(action:{
                    
                }){
                    Text("이메일로 회원가입하기")
                }
            }
            .padding(.bottom)
            HStack {
                Text("이미 가입 하셨나요?")
                NavigationLink(destination: Text("이메일 로그인 화면")) {
                    Text("로그인")
                }
            }
            Spacer()
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
