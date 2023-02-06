//
//  AuthStore.swift
//  AuthTest
//
//  Created by 장다영 on 2023/02/02.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftUI

// 현재 로그인한 user의 UID, 전역 변수로 지정
class UserStore: ObservableObject {
    
    @Published var user: User
    let database = Firestore.firestore()
    
    init() {
        user = User(id: "", email: "", followItemList: [], followShopList: [], nickname: "", pickupItemList: [], recentlyItem: [], userPhoneNumber: "")
    }
    
    func createUser(user: User) {
        database.collection("User")
            .document(user.email)
            .setData(["id" : user.id,
                      "email" : user.email,
                      "followItemList" : user.followItemList,
                      "followShopList" : user.followShopList,
                      "nickname" : user.nickname,
                      "pickupItemList" : user.pickupItemList,
                      "recentlyItem" : user.recentlyItem,
                      "userPhoneNumber" : user.userPhoneNumber])
        readUser(userId: user.email)
    }
    
    func readUser(userId: String) {
        database.collection("User").document(userId).getDocument { (snapshot, error) in
            
            let currentData = snapshot!.data()
            let email: String = currentData!["email"] as? String ?? ""
            let followItemList: [String] = currentData!["followItemList"] as? [String] ?? []
            let followShopList: [String] = currentData!["followShopList"] as? [String] ?? []
            let nickname: String = currentData!["nickname"] as? String ?? ""
            let pickupItemList: [String] = currentData!["pickupItemList"] as? [String] ?? []
            let recentlyItem: [String] = currentData!["recentlyItem"] as? [String] ?? []
            let userPhoneNumber: String = currentData!["userPhoneNumber"] as? String ?? ""
            self.user = User(id: userId, email: email, followItemList: followItemList, followShopList: followShopList, nickname: nickname, pickupItemList: pickupItemList, recentlyItem: recentlyItem, userPhoneNumber: userPhoneNumber)
        }
    }
    
    func updateUser(user: User) {
        database.collection("User").document(user.id)
            .updateData(["email" : user.email,
                         "followItemList" : user.followItemList,
                         "followShopList" : user.followShopList,
                         "nickname" : user.nickname,
                         "pickupItemList" : user.pickupItemList,
                         "recentlyItem" : user.recentlyItem,
                         "userPhoneNumber" : user.userPhoneNumber])
        readUser(userId: user.email)
    }
    
    func deleteUser(userId: String) {
        database.collection("User")
            .document(userId).delete()
    }
    
}
