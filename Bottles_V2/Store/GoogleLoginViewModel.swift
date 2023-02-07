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
    func signIn() {
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
        
        if let error = error {
            print(error.localizedDescription)
            return
        }
        
        guard let authentication = user?.authentication, let idToken = authentication.idToken else {
            return
        }
        
        let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: authentication.accessToken)
        
        Auth.auth().signIn(with: credential) { [unowned self] (_, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                
            }
        }
    }
    
    func signOut() {
        GIDSignIn.sharedInstance.signOut()
        
        do {
            try Auth.auth().signOut()
            
            
        } catch {
            print(error.localizedDescription)
        }
    }
}
