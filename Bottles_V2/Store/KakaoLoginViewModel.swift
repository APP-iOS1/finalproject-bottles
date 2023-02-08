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
    
    let userStore: UserStore = UserStore()
    
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
                if let oauthToken = oauthToken {
                    print("카카오톡: \(oauthToken)")
                    self.signUpInFirebase()
                }
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
                    if let oauthToken = oauthToken {
                        print("카카오톡: \(oauthToken)")
                        self.signUpInFirebase()
                    }
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
    
    // MARK: - 카카오톡 계정 파이어베이스 auth에 추가
    func signUpInFirebase() {
        UserApi.shared.me() { user, error in
            if let error = error {
                print("카카오톡 사용자 정보 가져오기 에러: \(error.localizedDescription)")
            } else {
                // 파이어베이스 유저 생성
                Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                    print("email: \(String(describing: user?.kakaoAccount?.email))")
                    
                    print("userid: \(String(describing: user?.id))")
                    
                    if let error = error {
                        print("파이어베이스 사용자 생성 실패: \(error.localizedDescription)")
                        print("파이어베이스 로그인 시작")
                        Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                            if let error = error {
                                print("로그인 에러: \(error.localizedDescription)")
                                return
                            } else {
                                print("카카오 파이어베이스 어스 로그인 성공")
                            }
                            
                        }
                       
                    } else {
                        self.userStore.createUser(user: User(id: (user?.kakaoAccount?.email)!, email: (user?.kakaoAccount?.email)!, followItemList: [], followShopList: [], nickname: (user?.kakaoAccount?.profile?.nickname)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: ""))
                        print("파이어베이스 사용자 생성 성공")

                    }
                    
                }
                
            }
            
        }
    }
}
