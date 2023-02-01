//
//  EmailLoginView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/01.
//

import SwiftUI

struct EmailLoginView: View {
    /// 페이스 아이디 Unlock
    @State private var isUnlocked = false
    
    @State var email: String = ""
    @State var password: String = ""
    
    /// 로그인 에러를 뷰에 보여주기 위해 필요한 변수
    @State var loginError: Bool = false
    
    /// 로그인 에러가 났을 때 텍스트로 사용자에게 보여주기 위한 변수
    var loginResult: String {
        loginError ? "이메일 또는 비밀번호가 일치하지 않습니다." : ""
    }
    var body: some View {
        VStack{
            
            Spacer()
            TextField("이메일", text: $email)
                .modifier(LoginTextFieldModifier(width: 280, height: 48))
                .padding(.bottom, -4)
            SecureField("Password", text: $password)
                .modifier(LoginTextFieldModifier(width: 280, height: 48))
            
            
            // 로그인 에러 났을 때 화면에 띄워줌
            Text("\(loginResult)")
                .foregroundColor(loginError ? .red : .primary)
                .font(.bottles12)
                .shakeEffect(trigger: loginError)
            
            Button(action: {
                // TODO: 로그인 로직이 들어오면 입력한 아이디, 비밀번호가 틀릴 경우 뷰에 보여줌
                loginError = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    loginError = false
                }
                Task{
                    
                }
            }){
                ZStack{
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 280, height: 48)
                    Text("로그인")
                        .fontWeight(.semibold)
                        .font(.bottles16)
                        .foregroundColor(.primary) // 다크모드 대응
                        .colorInvert() // primaryColor로 하게 되면 검은색을 색상 반전으로 하얀색으로 만들어 줌
                    
                }
            }
            
            NavigationLink(destination: Text("회원가입 뷰")) {
                Text("회원가입하기")
                    .modifier(LoginViewNavigationLinkModifier())
            }
            .padding(.top, 24)
            .padding(.bottom, 16)
            NavigationLink(destination: Text("비밀번호 찾기")){
                Text("비밀번호 찾기")
                    .modifier(LoginViewNavigationLinkModifier())
            }
            
            Spacer()
                .frame(height: 400)
            //            Button("Don`t have an account? Sign up.", action: {
            //
            //            })
            
        }
    }
}

//MARK: - EmailLoginView 회원가입하기, 비밀번호 찾기 Modifier
struct LoginViewNavigationLinkModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.bottles12)
            .foregroundColor(.gray)
            .underline()
    }
}


//MARK: - EmailLoginView 텍스트필드 Modifier
struct LoginTextFieldModifier: ViewModifier {
    var width: CGFloat
    var height: CGFloat
    func body(content: Content) -> some View {
        content
            .font(.bottles16)
            .padding()
            .textInputAutocapitalization(.never) // 처음 문자를 자동으로 대문자로 바꾸는걸 막기
            .frame(width: width)
            .background{
                RoundedRectangle(cornerRadius: 12)
                    .foregroundColor(.gray_f7)
                    .frame(width: width,height: height)
            }
    }
}
struct EmailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        EmailLoginView()
    }
}
