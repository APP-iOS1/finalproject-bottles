//
//  EmailRegisterView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/30.
//

import SwiftUI

struct EmailRegisterView: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// email확인 정규식
    let emailExpression: String = "^([a-zA-Z0-9._-])+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,20}$"
    
    /// 비밀번호 확인 정규식 (영어, 숫자, 특수문자 8~18자리)
    let passwordExpression: String = "^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+=-]).{8,15}$"
    
    @State var registerEmail: String = ""
    @State var verificationCode: String = ""
    @State var registerPassword: String = ""
    @State var passwordCheck: String = ""
    @State var nickname: String = ""
    @State var phoneNumber: String = ""
    
    /// 비밀번호 입력 창을 TextField로 보여주거나 SecureField로 보여주는 변수
    @State private var isShowingPasswordText: Bool = false
    
    /// 비밀번호 확인 입력창을 TextField로 보여주거나 SecureField로 보여주는 변수
    @State private var isShowingPasswordCheckText: Bool = false
    
    /// 중복확인 버튼을 누르고 이메일이 중복일 때 텍스트 필드 애니메이션을 활성화 시켜주는 변수
    @State private var emailError: Bool = false
    
    /// 비밀번호 양식이 올바르지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var passwordError: Bool = false
    
    /// 비밀번호 확인이 같지 않으면 사용자에게 뷰에서 에러를 표현해주는 변수
    @State private var checkingPasswordError: Bool = false
    
    /// 중복확인 버튼을 누르면 이메일 인증 번호 입력하는 창 띄워주는 변수
    @State private var isShowingVerificationCode: Bool = false
    
    /// 첫번째 이용약관 동의 변수
    @State var firstAgreement: Bool = false
    
    /// 개인정보 수집 이용 동의 변수
    @State var secondAgreement: Bool = false
    
    /// 만 19세 이상 동의 변수
    @State var thirdAgreement: Bool = false
    
    /// 이용약관 버튼 눌렀을 때 이동하는 웹링크 배열
    let agreementURLs: [String] = [
        "https://www.youtube.com/", // 이용약관 동의 링크
        "https://line.me/ko/", // 개인정보 수집·이용 동의 링크
        "https://www.kakaocorp.com/page/" // 만 19세 이상 동의 링크
    ]
    
    /// 이용약관 동의 필드의 텍스트 배열
    let agreementTitles: [String] = [
        "이용약관 동의",
        "개인정보 수집·이용 동의",
        "본인은 만 19세 이상입니다."
    ]
    
    /// SafariWebView에 바인딩으로 넘겨줄 웹 링크 각 버튼마다 눌렀을 때 링크가 변경된다.
    @State var selectedAgreementWebLink: URL = URL(string: "www.naver.com")!
    
    /// SafariWebView 시트로 띄우는 변수
    @State private var isShowingSheet: Bool = false
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
                .padding(.bottom, -5)
                HStack {
                    TextField("예: bottles@bottles.com", text: $registerEmail)
                        .keyboardType(.emailAddress)
                        .modifier(LoginTextFieldModifier(width: 250, height: 48))
                        .shakeEffect(trigger: emailError)
                    Button(action: {
                        //TODO 중복확인 로직
                        // 중복에 걸린다면 아래 코드를 넣어주시면 이펙트가 발동 됩니다. 어려울 것 같으면 지워도 돼요
                        emailError = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            emailError = false
                        }
                        // 이메일 인증 번호 입력창 활성화
                        isShowingVerificationCode.toggle()
                    }){
                       Text("중복확인")
                            .modifier(EmailViewButtonModifier(width: 100, height: 48))
                    }
                }
            }
            
            //MARK: - 이메일 인증번호 입력창
            if isShowingVerificationCode {
                Group {
                    HStack(alignment: .bottom) {
                        Text("이메일 인증")
                            .font(.bottles14)
                        + Text("*")
                            .foregroundColor(.accentColor)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, -5)
                    HStack{
                        TextField("인증번호를 입력해주세요.", text: $verificationCode)
                            .modifier(LoginTextFieldModifier(width: 225, height: 48))
                        Button(action: {
                            //TODO: 이메일 인증번호 확인 로직
                        }){
                            Text("인증번호 받기")
                                .modifier(EmailViewButtonModifier(width: 125, height: 48))
                        }
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
                    Spacer()
                    // 뷰에 비밀번호 형식이 맞는지 틀린지 사용자가 볼 수 있게 Text로 띄워준다.
                    Text("\(resultPasswordText)")
                        .font(.bottles12)
                        .foregroundColor(passwordNotFitFormat ? .secondary : .green)
                }
                .padding(.horizontal, 20)
                .padding(.bottom, isShowingPasswordText ? 2 : 3)
                ZStack {
                    if isShowingPasswordText {
                        TextField("영어, 숫자, 특수문자 포함 8~15자리", text: $registerPassword)
//                            .padding(.top, 10)
                            .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    } else {
                        SecureField("영어, 숫자, 특수문자 포함 8~15자리", text: $registerPassword)
                            .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    }
                    HStack{
                        Spacer()
                        Button(action:{
                            isShowingPasswordText.toggle()
                        }){
                            Image(systemName: isShowingPasswordText ? "eye.slash" : "eye")
                        }
                    }
                    .padding(.trailing, 30)
                }
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
                .padding(.top, isShowingPasswordText ? 4.5 : 5)
                .padding(.bottom, isShowingPasswordCheckText ? 2 : 3)
                ZStack{
                    if isShowingPasswordCheckText {
                        TextField("비밀번호 확인", text: $passwordCheck)
                            .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    } else {
                        SecureField("비밀번호 확인", text: $passwordCheck)
                            .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    }
                    HStack{
                        Spacer()
                        Button(action:{
                            isShowingPasswordCheckText.toggle()
                        }){
                            Image(systemName: isShowingPasswordCheckText ? "eye.slash" : "eye")
                        }
                    }
                    .padding(.trailing, 30)
                }
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
                .padding(.top, isShowingPasswordCheckText ? 4.5 : 5)
                .padding(.bottom, -5)
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
                .padding(.bottom, -5)
                TextField("숫자만 입력해주세요", text: $phoneNumber)
                    .modifier(LoginTextFieldModifier(width: 357, height: 48))
                    .keyboardType(.numberPad)
            }
            
            // MARK: - 이용약관동의
            Group {
                HStack {
                    Text("이용약관동의")
                        .font(.bottles14)
                    + Text("*")
                        .foregroundColor(.accentColor)
                    Spacer()
                }
                .padding(20)
                // MARK: - 이용약관 전체동의
                Button(action: {
                    firstAgreement.toggle()
                    secondAgreement.toggle()
                    thirdAgreement.toggle()
                }){
                    HStack{
                        Image(systemName: "checkmark.circle")
                            .font(.title2)
                            .foregroundColor(firstAgreement && secondAgreement && thirdAgreement ? .accentColor : .secondary)
                        Text("전체 동의합니다.")
                            .font(.bottles19)
                            .foregroundColor(.primary)
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    
                }
                Divider()
                    .padding(.horizontal, 16)
                // MARK: - 이용약관 동의 체크 버튼
                HStack {
                    VStack(spacing: 10) {
                        Button(action: {
                            firstAgreement.toggle()
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(firstAgreement ? .accentColor : .secondary)
                                .font(.title2)
                        }
                        Button(action: {
                            secondAgreement.toggle()
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(secondAgreement ? .accentColor : .secondary)
                                .font(.title2)
                        }
                        Button(action: {
                            thirdAgreement.toggle()
                        }) {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(thirdAgreement ? .accentColor : .secondary)
                                .font(.title2)
                        }
                    }
                    //MARK: - 이용약관 텍스트 눌렀을 때 웹으로 이동
                    VStack (alignment: .leading, spacing: 20){
                        ForEach(0 ..< agreementURLs.count, id: \.self){ index in
                            Button(action: {
                                selectedAgreementWebLink = URL(string: "\(agreementURLs[index])")!
                                isShowingSheet.toggle()
                            }){
                                HStack{
                                    Text("\(agreementTitles[index]) ")
                                        .foregroundColor(.primary)
                                    + Text("(필수)")
                                        .foregroundColor(.secondary)
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                        .foregroundColor(.secondary)
                                }
                            }
                            .font(.bottles12)
                            .sheet(isPresented: $isShowingSheet) {
                                SafariWebView(selectedUrl: $selectedAgreementWebLink)
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            Button(action: {
                // TODO: 이메일로 회원가입 로직 넣기
            }){
                Text("회원가입하기")
                    .modifier(EmailViewButtonModifier(width: 358, height: 56))
            }
            
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    //MARK: - 뷰에 사용되는 연산프로퍼티들
    
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
    
    /// 뷰에 이메일 형식이 맞는지 텍스트로 띄워주는 연산 프로퍼티
    private var resultEmailText: String {
        if registerEmail == "" {
            return ""
        } else {
            return emailNotFitFormat ? "올바른 이메일 형식이 아닙니다." : "사용 가능한 이메일 입니다."
        }
    }
    
    /// 뷰에 비밀번호 형식이 맞는지 텍스트로 띄워주는 연산 프로퍼티
    private var resultPasswordText: String {
        if registerPassword == "" {
            return ""
        } else {
            return passwordNotFitFormat ? "영어, 숫자, 특수문자 포함 8~15자리" : "사용 가능한 비밀번호 입니다."
        }
    }
    
    /// 뷰에 비밀번호 확인이 비밀번호 입력한 값과 맞는지 텍스트로 띄워주는 연산프로퍼티
    private var resultPasswordCheckText: String {
        if passwordCheck == "" {
            return ""
        } else {
            return passwordCheckFail ? "비밀번호가 일치하지 않습니다." : "비밀번호가 일치합니다."
        }
    }
    
    /// CustomNavigationBackButton
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }
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
