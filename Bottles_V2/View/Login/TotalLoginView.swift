//
//  TotalLoginView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/01.
//

import SwiftUI

struct TotalLoginView: View {
    @StateObject var googleLoginViewModel: GoogleLoginViewModel = GoogleLoginViewModel()
    @StateObject var kakaoLoginViewModel: KakaoLoginViewModel = KakaoLoginViewModel()
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
                        kakaoLoginViewModel.handleKakaoLogin()
                    }){
                        VStack {
                            Image("KakaoLogin")
                                .socialLoginImageModifier()
                            Text("카카오")
                        }
                    }
                    
                    Button(action: {
                        // TODO: 구글 로그인 로직
                        googleLoginViewModel.signIn()
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
                        Task {
                            await kakaoLoginViewModel.handleKakaoLogout()
                        }
                    }){
                        VStack {
                            Image("FacebookLogin")
                                .socialLoginImageModifier()
                            Text("페이스북")
                        }
                    }
                    .padding(.trailing)
                    Button(action: {
                        // TODO: 애플 로그인 로직
                        googleLoginViewModel.signOut()
                    }){
                        VStack {
                            Image("AppleLogin")
                                .socialLoginImageModifier()
                            Text("애플")
                        }
                    }
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
    }
}

struct TotalLoginView_Previews: PreviewProvider {
    static var previews: some View {
        TotalLoginView()
    }
}
