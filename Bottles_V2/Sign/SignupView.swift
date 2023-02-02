//
//  Signup.swift
//  Todo
//
//  Created by mac on 2023/01/11.
//

//email, 유저이름, password로 회원가입하는 함수.
import Foundation
import SwiftUI
//import Amplify

//struct SignUpView: View{
////    @EnvironmentObject var sessionManager : SessionManager
//    
//    @State var username = ""
//    @State var email = ""
//    @State var password = ""
//    @FocusState var isInFocusEmail: Bool
//    @FocusState var isInFocusPassword: Bool
//    @FocusState var isInFocusPasswordCheck: Bool
//    @State private var isSecuredPassword = true
//    @State private var isSecuredPasswordCheck = true
//    @State private var isDuplicated = true
//    @State private var isNotDuplicated = false
//    
//    func checkEmailRule(string: String) -> Bool {
//        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
//        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: string)
//    }
//    
//    func checkPasswordRule(password : String) -> Bool {
//        let regExp = "^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,12}$"
//        return password.range(of: regExp, options: .regularExpression) != nil
//    }
//    
//    var body: some View{
//        VStack{
//            Spacer()
//            
//            TextField("Username", text: $username)
//            
//            HStack{
//                TextField("Email", text: $email)
//                Button("중복검사", action:{
//                    
//                })
//                
//            }
//            
//            SecureField("Password", text: $password)
//            
//            Button("Sign Up", action: {
//                Task{
//                    await sessionManager.signUp(username: username, password: password, email: email)
//                }
//            })
//            
//            Spacer()
//            Button("Already have an account? Log in.", action: {
//                sessionManager.showLogin()
//            })
//            
//            
//        }.padding()
//    }
//    
//    
//    
//    
//}
