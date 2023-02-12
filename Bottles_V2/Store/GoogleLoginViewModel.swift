//
//  GoogleLoginViewModel.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/07.
//

import Foundation
import Firebase

import GoogleSignIn

class GoogleLoginViewModel: ObservableObject {
    
    let userStore: UserStore = UserStore()
    
    
    /// 데이터 베이스 안에 같은 이메일이 있을 때 customAlert을 띄워줌
    @Published var googleLoginError: Bool = false
    
    
    /// 데이터 베이스 안에 같은 이메일이 있으면 CustomAlert의 내용에 사용자가 어떤 종류의 계정으로 회원 가입 했는지 보여줌
    var errorSocialType: String = ""
    
    @Published var currentUser: Firebase.User?
    
    /// 뷰전환을 위해 필요한 Bool타입 변수
    @Published var googleLogin: Bool = false
    
    init() {
        currentUser = Auth.auth().currentUser
    }
    
    
    
    func signIn(){
        
        if GIDSignIn.sharedInstance.hasPreviousSignIn() {
            GIDSignIn.sharedInstance.restorePreviousSignIn { [unowned self] user, error in
                authenticateUser(for: user, with: error)
                
            }
        } else {
            guard let clientID = FirebaseApp.app()?.options.clientID else {
                return
            }
            
            let configuration = GIDConfiguration(clientID: clientID)
            
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
                return
            }
            guard let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }
            
            
            GIDSignIn.sharedInstance.signIn(with: configuration, presenting: rootViewController) { [unowned self] user, error in
                authenticateUser(for: user, with: error)
               
            }
            
        }
    
    }
    
    
    private func authenticateUser(for user: GIDGoogleUser?, with error: Error?) {
        let type = "구글"
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        Firestore.firestore().collection("User").whereField("email", isEqualTo: (user?.profile?.email)!)
            .getDocuments { snapshot, error in
                if snapshot!.documents.isEmpty {
                    if let error = error {
                        print("\(error.localizedDescription)")
                    } else {
                        Auth.auth().signIn(with: credential) { [unowned self] (result, error) in
                            if let error = error {
                                print(error.localizedDescription)
                                print("로그인 실패")
                            } else {
                                self.currentUser = result?.user
                                self.userStore.createUser(user: User(id: (user?.profile?.email)!, email: (user?.profile?.email)!, followItemList: [], followShopList: [], nickname: (user?.profile?.name)!, pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: UserStore.shared.fcmToken ?? ""))
                                self.googleLogin = true
                                print("로그인 성공")
                            }
                        }
                    }
                } else {
                    Firestore.firestore().collection("User").document((user?.profile?.email)!)
                        .getDocument { snapshot, error in
                            
                            let currentData = snapshot!.data()
                            let email: String = currentData!["email"] as? String ?? ""
                            let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
                            
                            if socialLoginType == type {
                                Auth.auth().signIn(with: credential) { result, error in
                                    if let error = error {
                                        print("구글 로그인 에러: \(error.localizedDescription)")
                                        return
                                    } else {
                                        self.currentUser = result?.user
                                       
                                    }
                                    
                                }
                            } else {
                                GIDSignIn.sharedInstance.signOut()
                                self.errorSocialType = socialLoginType
                                
                            }
                        }
                }
            
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            currentUser = nil
        } catch {
            print(error.localizedDescription)
        }
    }
}
