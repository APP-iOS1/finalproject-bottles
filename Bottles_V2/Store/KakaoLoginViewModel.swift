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
    
    /// 데이터 베이스 안에 같은 이메일이 있으면 customAlert을 뷰에 띄워줌
    @Published var kakaoLoginError: Bool = false
    
    /// 데이터 베이스 안에 같은 이메일이 있으면 customAlert의 내용에 사용자가 어떤 종류의 소셜 로그인으로 회원 가입했는지 보여줌
    var errorSocialType: String = ""
    
    
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
        var type = "카카오"
        UserApi.shared.me() { user, error in
            if let error = error {
                print("카카오톡 사용자 정보 가져오기 에러: \(error.localizedDescription)")
            } else {
                // 1, FireStore User 컬렉션 documentID == email 일치하는게 있는지 확인 = 기존 등록된 계정 있는지 확인
                // if 있으면 documentID 하위의 필드의 socialLoginType을 가져와 "카카오"와 type이 같은지 확인
                // 같으면 로그인
                // 다르면 dimiss 시키고, 알림으로 socialLoginType으로 로그인 하시라고 안내
                // 2. documentID == email 없으면 Auth 유저 생성 및 FireStore 유저 생성
                Firestore.firestore().collection("User").whereField("email", isEqualTo: (user?.kakaoAccount?.email)!)
                    .getDocuments { snapshot, error in
                        if snapshot!.documents.isEmpty {
                            // 회원가입으로 넘기는 부분
                            FirebaseAuth.Auth.auth().createUser(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                                print("email: \(String(describing: user?.kakaoAccount?.email))")
                                
                                print("userid: \(String(describing: user?.id))")
                                
                                if let error = error {
                                    print("에러 발생")
                                    
                                } else {
                                    self.userStore.createUser(user: User(id: (user?.kakaoAccount?.email)!, email: (user?.kakaoAccount?.email)!, followItemList: [], followShopList: [], nickname: (user?.kakaoAccount?.profile?.nickname)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: ""))
                                    print("파이어베이스 사용자 생성 성공")
                                    
                                }
                                
                            }
                            
                            
                            
                        } else {
                            Firestore.firestore().collection("User").document((user?.kakaoAccount?.email)!).getDocument { (snapshot, error) in
                                
                                let currentData = snapshot!.data()
                                let email: String = currentData!["email"] as? String ?? ""
                                let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                                
                                if socialLoginType == type {
                                    // 로그인 처리 (auth에 로그인 -> 뷰를 넘겨줌)
                                    Auth.auth().signIn(withEmail: (user?.kakaoAccount?.email)!, password: "\(String(describing: user?.id))") { result, error in
                                        if let error = error {
                                            print("로그인 에러: \(error.localizedDescription)")
                                            return
                                        } else {
                                            print("카카오 파이어베이스 어스 로그인 성공")
                                            //  뷰 전환
                                        }
                                        
                                    }
                                    
                                } else {
                                    // 프로세스 종료 및 socialLoginType를 사용자에게 알려줌
                                    // 키카오 언링크 & 웹 끄기
                                    UserApi.shared.unlink {(error) in
                                        if let error = error {
                                            print(error)
                                        }
                                        else {
                                            print("unlink() success.")
                                            // MARK: 사용자에게 무언가 알려줘야 함
                                            self.errorSocialType = socialLoginType
                                            self.kakaoLoginError = true
                                        }
                                    }
                                    // 뷰를 login뷰로 다시 넘겨주기 (따로 없어도 됨)
                                }
                            }
                            
                        }
                    }
                
            }
        }
    }
}
