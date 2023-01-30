//
//  EmailRegisterView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/30.
//

import SwiftUI

struct EmailRegisterView: View {
    /// email확인 정규식
    let emailExpression: String = "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,20}$"
    
    /// 비밀번호 확인 정규식 (영어, 숫자, 특수문자 8~18자리)
    let passwordExpression: String = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,15}$"
    
    @State private var registerEmail: String = ""
    @State private var registerPassword: String = ""
    @State private var passwordCheck: String = ""
    
    /// 이메일 양식이 올바르지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var emailError: Bool = false
    
    /// 비밀번호 양식이 올바르지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var passwordError: Bool = false
    
    /// 비밀번호 확인이 같지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var checkingPasswordError: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            // MARK: - email 입력창
            Group {
                Text("이메일")
                    .font(.bottles12)
                TextField("예: bottles@bottles.com", text: $registerEmail)
                    .checkRegisterEffect(trigger: emailError)
                
                // 뷰에 이메일 형식이 맞는지 틀린지 사용자가 볼 수 있게 Text로 띄워준다.
                if registerEmail == "" {
                    Text("")
                        .frame(height: 7)
                } else {
                    emailNotFitFormat ? Text("올바른 이메일 형식이 아닙니다.").font(.bottles12).foregroundColor(.red) : Text("사용가능한 이메일입니다.").font(.bottles12).foregroundColor(.green)
                }
            }
            
            // MARK: - 비밀번호 입력창
            Group {
                Text("비밀번호")
                    .font(.bottles12)
                TextField("영어, 숫자, 특수문자 포함 8~15자리", text: $registerPassword)
                    .checkRegisterEffect(trigger: passwordError)
                
                // 뷰에 비밀번호 형식이 맞는지 틀린지 사용자가 볼 수 있게 Text로 띄워준다.
                
                if registerPassword == "" {
                  Text("")
                        .frame(height: 7)
                } else {
                    passwordNotFitFormat ? Text("영문, 숫자, 특수문자를 조합하여 8~15자리로 만들어 주세요").font(.bottles12).foregroundColor(.red) : Text("사용가능한 비밀번호입니다.").font(.bottles12).foregroundColor(.green)
                }
                
            }
            
            // MARK: - 비밀번호 확인
            Group {
                Text("비밀번호 확인")
                    .font(.bottles12)
                TextField("비밀번호 확인", text: $passwordCheck)
                    .checkRegisterEffect(trigger: checkingPasswordError)
                
                if passwordCheck == "" {
                    Text("")
                        .frame(height: 7)
                } else {
                    passwordCheckFail ? Text("비밀번호가 틀립니다")
                }
            }
            
            Button(action: {
                if emailNotFitFormat {
                    emailError = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        emailError = false
                    }
                } else if passwordNotFitFormat {
                    passwordError = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        passwordError = false
                    }
                } else if passwordCheckFail {
                    checkingPasswordError = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        checkingPasswordError = false
                    }
                } else {
                    // TODO: 이메일로 회원가입 로직 넣기
                }
            }){
                Text("회원가입")
            }
            
        }
    }
    
    /// 이메일이 정규식에 맞는지 확인 해주는 연산프로퍼티
    private var emailNotFitFormat: Bool {
        registerEmail.range(of: emailExpression, options: .regularExpression) == nil
    }
    
    /// 비밀번호가 정규식에 맞는지 확인해주는 연산프로퍼티
    private var passwordNotFitFormat: Bool {
        registerPassword.range(of: passwordExpression, options: .regularExpression) == nil
    }
    
    /// 비밀번호와 비밀번호 확인해주는 연산프로퍼티
    private var passwordCheckFail: Bool {
        passwordCheck != registerPassword
    }
}


// MARK: - 쉐이크 이펙트

struct ShakeEffect: ViewModifier {
    
    var trigger: Bool
    
    @State private var isShaking = false
    
    func body(content: Content) -> some View {
        content // 수정자가 적용되는 곳 '위' 까지의 View
            .offset(x: isShaking ? -6 : .zero)
            .animation(.default.repeatCount(3).speed(6), value: isShaking)
            .onChange(of: trigger) { newValue in
                guard newValue else { return }
                isShaking = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    isShaking = false
                }
            }
    }
}

struct TextFieldModifier: ViewModifier {
    var trigger: Bool
    
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(height: 40)
            .background{
                RoundedRectangle(cornerRadius: 5)
                    .stroke(trigger ? .red : .secondary)
            }
            .shakeEffect(trigger: trigger)
            .autocapitalization(.none)
    }
}

struct EmailRegisterView_Previews: PreviewProvider {
    static var previews: some View {
        EmailRegisterView()
    }
}
