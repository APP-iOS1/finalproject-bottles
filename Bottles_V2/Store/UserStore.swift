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
    
    /// 이메일 중복확인 결과에 따른 EmailRegisterView에서 CustomAlert의 String
    @Published var emailCheckStr: String = ""
    
    /// emailRegisterView에서 중복확인에 걸리지 않으면 인증코드 입력 화면을 띄워준다.
    @Published var isShowingVerificationCode: Bool = false
    
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
    
    /// email 중복확인 메소드
    func doubleCheckEmail(userEmail: String) {
        database.collection("User")
            .whereField("email", isEqualTo: userEmail)
            .getDocuments { snapshot, error in
                if snapshot!.documents.isEmpty {
                    print("사용 가능한 이메일입니다.")
                    self.emailCheckStr = "사용 가능한 이메일입니다."
                    self.isShowingVerificationCode = true
                } else {
                    print("중복된 이메일 입니다. 다른 이메일을 사용해주세요")
                    self.emailCheckStr = "중복된 이메일 입니다. 다른 이메일을 사용해주세요"
                    self.isShowingVerificationCode = false
                }
            }
                
            
    }
}
