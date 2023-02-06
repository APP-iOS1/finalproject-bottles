//
//  FindPasswordView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/06.
//

import SwiftUI

struct FindPasswordView: View {
    
    @StateObject var authStore: AuthStore
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var email = ""
    
    private var findResultText: String {
        authStore.loginError ? "이메일을 다시 한번 확인해주세요." : ""
    }
    var body: some View {
        
        if authStore.resetPassword{
            SentEmailView(email: email)
                .navigationBarBackButtonHidden(true)
                .navigationTitle("비밀번호 찾기")
                .navigationBarItems(leading: backButton)
        } else {
            VStack{
                HStack{
                    Text("이메일")
                        .font(.bottles14)
                    Spacer()
                }
                .padding(.horizontal, 20)
                TextField("이메일을 입력해주세요", text: $email)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))
                Text("\(findResultText)")
                    .frame(height: 10)
                    .foregroundColor(authStore.loginError ? .red : .primary)
                    .font(.bottles12)
                    .shakeEffect(trigger: authStore.loginError)
                Button(action: {
                    authStore.sendPasswordReset(email: email)
                    print("\(authStore.resetPassword)")
                    
                }){
                    Text("확인")
                        .modifier(EmailViewButtonModifier(width: 357, height: 48))
                }
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationTitle("비밀번호 찾기")
            .navigationBarItems(leading: backButton)
        }
       
    }
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
                authStore.resetPassword = false
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }
    }
}

struct FindPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        FindPasswordView(authStore: AuthStore())
    }
}
