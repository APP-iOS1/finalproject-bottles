//
//  KakaoLoginViewModel.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/07.
//

import Foundation
import Combine
import KakaoSDKAuth
import KakaoSDKUser
import Firebase
import FirebaseAuth

class KakaoLoginViewModel: ObservableObject {
    
    func handleKakaoLogin() {
        // 카카오톡 설치 여부 확인 - 카카오톡이 설치가 되어있을 때
        Task {
            if (UserApi.isKakaoTalkLoginAvailable()) {
                await loginWithKakaoApp()
            } else {
                // 카카톡이 설치가 되어 있지않을 때 카카오 웹뷰로 로그인
                await loginWithKakaoAccount()
            }
        }
    }
    
    /// 카카오 앱을 통해 로그인
    private func loginWithKakaoApp() async {
        UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
            if let error = error {
                print(error)
            }
            else {
                print("loginWithKakaoTalk() success.")
                //TODO: FirebaseAuth에 심어야 함
                //do something
                _ = oauthToken
            }
        }
    }
    
    /// 카카오 앱이 없을 시 웹으로 띄워서 로그인
    private func loginWithKakaoAccount() async {
        UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                if let error = error {
                    print(error)
                }
                else {
                    print("loginWithKakaoAccount() success.")
                    //TODO: FirebaseAuth에 심어야 함
                    //do something
                    _ = oauthToken
                }
            }
    }
    
    func handleKakaoLogout() async {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                print("logout() success.")
            }
        }
    }
}
