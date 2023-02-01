//
//  LoginView.swift
//  Todo
//
//  Created by mac on 2023/01/11.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var sessionManager : SessionManager
    
    @State private var isUnlocked = false
    
    @State var email = ""
    @State var password = ""
    @State var passwordCheck = ""
    var colorOfLoginButton: Color {
            if email.isEmpty || password.isEmpty {
                return Color(hue: 0.101, saturation: 0.536, brightness: 0.981)
            } else {
                return .orange
            }
        }
    
    
    
    var body: some View {
        
            VStack{
                
                Spacer()
                TextField("이메일", text: $email)
//                    .modifier(LoginTextFieldModifier(width: <#CGFloat#>, height: <#CGFloat#>))
                    .padding(.bottom, -4)
                SecureField("Password", text: $password)
//                    .modifier(LoginTextFieldModifier())
//                    .textInputAutocapitalization(.never)// 처음 문자를 자동으로 대문자로 바꾸는걸 먹기
                Button(action: {
                    Task{
                        await sessionManager.signIn(email: email, password: password)
                    }
                }){
                    VStack{
                        Text("로그인")
                            .font(.bottles16)
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 280, height: 48)
                            }
                    }
                }
                //.disabled(email.isEmpty || password.isEmpty )
                
                Spacer()
                Button("Don`t have an account? Sign up.", action: {
                    sessionManager.showSignUp()
                })
            
            }
//            .navigationTitle(Text("로그인").font(.bottles18))
            .task{
//                await sessionManager.getCurrentAuthUser()
                
            }
        
    }
    func faceIDAuth()  {
        let context = LAContext()
        var error: NSError?
        
        // check whether biometric authentication is possible
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // it's possible, so go ahead and use it
            let reason = "We need to unlock your data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                // authentication has now completed
                if success {
                    isUnlocked = true
                } else {
                    // there was a problem
                }
            }
        } else {
            // no biometrics
        }
    }
    
}






struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
