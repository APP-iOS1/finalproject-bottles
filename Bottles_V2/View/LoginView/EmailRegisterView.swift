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
    
    @State var registerEmail: String = ""
    @State var registerPassword: String = ""
    @State var passwordCheck: String = ""
    @State var nickname: String = ""
    @State var phoneNumber: String = ""
    
    /// 이메일 양식이 올바르지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var emailError: Bool = false
    
    /// 비밀번호 양식이 올바르지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var passwordError: Bool = false
    
    /// 비밀번호 확인이 같지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var checkingPasswordError: Bool = false
    
    /// 뷰에 이메일 형식이 맞는지 띄워주는 연산 프로퍼티
    private var resultEmailText: String {
        if registerEmail == "" {
            return ""
        } else {
            return emailNotFitFormat ? "올바른 이메일 형식이 아닙니다." : "사용 가능한 이메일 입니다."
        }
    }
    
    /// 뷰에 비밀번호 형식이 맞는지 띄워주는 연산 프로퍼티
    private var resultPasswordText: String {
        if registerPassword == "" {
            return ""
        } else {
            return passwordNotFitFormat ? "영어, 숫자, 특수문자 포함 8~15자리" : "사용 가능한 비밀번호 입니다."
        }
    }
    
    /// 뷰에 비밀번호 확인이 비밀번호 입력한 값과 맞는지 띄워주는 연산프로퍼티
    private var resultPasswordCheckText: String {
        if passwordCheck == "" {
            return ""
        } else {
            return passwordCheckFail ? "비밀번호가 일치하지 않습니다." : "비밀번호가 일치합니다."
        }
    }
    var body: some View {
        ScrollView {
            // MARK: - email 입력창
            Group {
                HStack(alignment:.bottom){
                    Text("이메일")
                        .font(.bottles14)
                    + Text("*")
                        .foregroundColor(.accentColor)
                    Spacer()
                    // 뷰에 이메일 형식이 맞는지 틀린지 사용자가 볼 수 있게 Text로 띄워준다.
                    Text("\(resultEmailText)")
                        .font(.bottles12)
                        .foregroundColor(emailNotFitFormat ? .red : .green)
                }
                .padding(.horizontal, 20)
                HStack {
                    TextField("예: bottles@bottles.com", text: $registerEmail)
                        .modifier(LoginTextFieldModifier(width: 250, height: 48))
                    Button(action: {
                        //TODO 중복확인 로직
                    }){
                       Text("중복확인")
                            .modifier(EmailViewButtonModifier(width: 100, height: 48))
                    }
                }
            
            }
            
            // MARK: - 비밀번호 입력창
            Group {
                HStack(alignment: .bottom){
                    Text("비밀번호")
                        .font(.bottles14)
                    + Text("*")
                        .foregroundColor(.accentColor)
                    // 뷰에 비밀번호 형식이 맞는지 틀린지 사용자가 볼 수 있게 Text로 띄워준다.
                    Spacer()
                    Text("\(resultPasswordText)")
                        .font(.bottles12)
                        .foregroundColor(passwordNotFitFormat ? .secondary : .green)
                }
                .padding(.horizontal, 20)
                TextField("영어, 숫자, 특수문자 포함 8~15자리", text: $registerPassword)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))

            }
            
            // MARK: - 비밀번호 확인
            Group {
                HStack {
                    Text("비밀번호 확인")
                        .font(.bottles14)
                    + Text("*")
                        .foregroundColor(.accentColor)
                    Spacer()
                    Text("\(resultPasswordCheckText)")
                        .font(.bottles12)
                        .foregroundColor(passwordCheckFail ? .red : .green)
                }
                .padding(.horizontal, 20)
                TextField("비밀번호 확인", text: $passwordCheck)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))
                
            }
            
            // MARK: - 닉네임 입력
            Group {
                HStack {
                    Text("닉네임")
                        .font(.bottles14)
                    + Text("*")
                        .foregroundColor(.accentColor)
                    Spacer()
                }
                .padding(.horizontal, 20)
                TextField("닉네임을 입력해주세요", text: $nickname)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))
            }
            
            // MARK: - 휴대폰
            Group {
                HStack {
                    Text("휴대폰")
                        .font(.bottles14)
                    Spacer()
                }
                .padding(.horizontal, 20)
                TextField("숫자만 입력해주세요", text: $phoneNumber)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    .keyboardType(.numberPad)
            }
            Button(action: {
//                if emailNotFitFormat {
//                    emailError = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        emailError = false
//                    }
//                } else if passwordNotFitFormat {
//                    passwordError = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        passwordError = false
//                    }
//                } else if passwordCheckFail {
//                    checkingPasswordError = true
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//                        checkingPasswordError = false
//                    }
//                } else {
//                    // TODO: 이메일로 회원가입 로직 넣기
//                }
            }){
                Text("회원가입하기")
                    .modifier(EmailViewButtonModifier(width: 358, height: 56))
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
    
    /// 비밀번호와 비밀번호 확인이 서로 다르면 true 서로 같으면 false
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

// TODO: 필요 없음 나중에 지울 것 extension View+ 파일에서도 지우기
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
