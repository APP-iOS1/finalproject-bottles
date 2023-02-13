//
//  TotalLoginView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/01.
//

import SwiftUI
import AuthenticationServices

struct TotalLoginView: View {
    @EnvironmentObject var authStore: AuthStore
    
    
    var body: some View {
        NavigationStack {
            Spacer()
            Image("AppLogo_Final")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180)
                .padding(.bottom, 10)
            Text("내 주변의 바틀샵을 내 손 안에!")
                .font(.bottles13)
                .bold()
            Spacer()
                .frame(height: 230)
            
            VStack{
                HStack {
                    Rectangle()
                        .frame(width: 116, height: 0.3)
                        .foregroundColor(.gray)
                    Text("간편로그인")
                        .font(.bottles12)
                    Rectangle()
                        .frame(width: 116, height: 0.3)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 15)
                
                HStack {
                    Button(action: {
                        // TODO: 카카오 로그인 로직
                        Task{
                            await authStore.handleKakaoLogin()
                        }
                    }){
                        VStack {
                            Image("KakaoLogin")
                                .socialLoginImageModifier()
                            Text("카카오")
                        }
                    }
                    
                    Button(action: {
                        // TODO: 구글 로그인 로직
                        authStore.googleSignIn()
                        
                    }){
                        VStack {
                            Image("GoogleLogin")
                                .socialLoginImageModifier()
                            Text("구글")
                        }
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        // TODO: 페이스북 로그인 로직
//                        kakaoViewRouter()
                        authStore.facebookLogin()
                    }){
                        VStack {
                            Image("FacebookLogin")
                                .socialLoginImageModifier()
                            Text("페이스북")
                        }
                    }
                    .padding(.trailing)
                    VStack {
                        Image("AppleLogin")
                            .socialLoginImageModifier()
                        Text("애플")
                    }
                    .overlay {
                        SignInWithAppleButton { (request) in
                            // requesting paramertes from apple login...
                            authStore.nonce = randomNonceString()
                            request.requestedScopes = [.email, .fullName]
                            request.nonce = sha256(authStore.nonce)
                        } onCompletion: { (result) in
                            switch result {
                            case .success(let user):
                                print("success")
                                // do login with firebase...
                                guard let credential = user.credential as? ASAuthorizationAppleIDCredential else {
                                    print("error with firebase")
                                    return
                                }
                                authStore.appleLogin(credential: credential)
                            case .failure(let error):
                                print(error.localizedDescription)
                            }
                        }
                        .frame(width: 48)
                        .blendMode(.overlay)
                    }
                    .clipped()
                }
                .font(.bottles12)
                .foregroundColor(.gray)
            }
            .padding(.vertical, 40)
            NavigationLink(destination: EmailLoginView()) {
                Text("이메일로 로그인")
                    .font(.bottles12)
                    .foregroundColor(.gray)
                    .underline()
            }
            .padding(.top, 10)
            .padding(.bottom, 40)
            
        }
        .customAlert(isPresented: $authStore.loginError, message: "\(authStore.errorSocialType)계정으로 이미 가입 된 계정이 있습니다.", primaryButtonTitle: "확인", primaryAction: {}, withCancelButton: false)
        
        
    }
    
    
}

struct TotalLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TotalLoginView().environmentObject(AuthStore())
    }
}
