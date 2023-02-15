//
//  UserStore.swift
//  UserTest
//
//  Created by 장다영 on 2023/02/02.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import SwiftUI


class UserStore: ObservableObject {
    //fcmToken을 외부 extension AppDelegate의 application 함수에서 저장해주기 위함
    static let shared = UserStore()
    var fcmToken: String?
    @Published var user: User
    
    //let database = Firestore.firestore()
    
    /// 이메일 중복확인 결과에 따른 EmailRegisterView에서 CustomAlert의 String
    @Published var emailCheckStr: String = ""
    
    @Published var isShowingVerification: Bool = false
    
    init() {
        user = User(id: "", email: "", followItemList: [], followShopList: [], nickname: "", pickupItemList: [], recentlyItem: [], userPhoneNumber: "", deviceToken: "", noticeList: [], socialLoginType: "")
    }
    
    func createUser(user: User) {
        Firestore.firestore().collection("User")
            .document(user.email)
            .setData(["id" : user.id,
                      "email" : user.email,
                      "followItemList" : user.followItemList,
                      "followShopList" : user.followShopList,
                      "nickname" : user.nickname,
                      "pickupItemList" : user.pickupItemList,
                      "recentlyItem" : user.recentlyItem,
                      "userPhoneNumber" : user.userPhoneNumber,
                      "deviceToken" : user.deviceToken,
                      "noticeList" : user.noticeList,
                      "socialLoginType" : user.socialLoginType
                     ]
            )
        readUser(userId: user.email)
    }
    
    func readUser(userId: String) {
        Firestore.firestore().collection("User").document(userId).getDocument { (snapshot, error) in
            
            let currentData = snapshot!.data()
            let email: String = currentData!["email"] as? String ?? ""
            let followItemList: [String] = currentData!["followItemList"] as? [String] ?? []
            let followShopList: [String] = currentData!["followShopList"] as? [String] ?? []
            let nickname: String = currentData!["nickname"] as? String ?? ""
            let pickupItemList: [String] = currentData!["pickupItemList"] as? [String] ?? []
            let recentlyItem: [String] = currentData!["recentlyItem"] as? [String] ?? []
            let userPhoneNumber: String = currentData!["userPhoneNumber"] as? String ?? ""
            let deviceToken: String = currentData!["deviceToken"] as? String ?? ""
            let noticeList: [String] = currentData!["noticeList"] as? [String] ?? []
            let socialLoginType: String = currentData!["socialLoginType"] as? String ?? ""
            self.user = User(id: userId, email: email, followItemList: followItemList, followShopList: followShopList, nickname: nickname, pickupItemList: pickupItemList, recentlyItem: recentlyItem, userPhoneNumber: userPhoneNumber, deviceToken: deviceToken, noticeList: noticeList, socialLoginType: socialLoginType)
        }
    }
    
    //    func readUserOnly(userId: String) async {
    //
    //        do {
    //            let documents = try await Firestore.firestore().collection("User").document("test@naver.com").getDocument()
    //            if let docData = documents.data(){
    //                // 있는지를 따져서 있으면 데이터 넣어주고, 없으면 옵셔널 처리
    //
    //                let email: String = docData["email"] as? String ?? ""
    //                let followItemList: [String] = docData["followItemList"] as? [String] ?? []
    //                let followShopList: [String] = docData["followShopList"] as? [String] ?? []
    //                let nickname: String = docData["nickname"] as? String ?? ""
    //                let pickupItemList: [String] = docData["pickupItemList"] as? [String] ?? []
    //                let recentlyItem: [String] = docData["recentlyItem"] as? [String] ?? []
    //                let userPhoneNumber: String = docData["userPhoneNumber"] as? String ?? ""
    //                self.user = User(id: userId, email: email, followItemList: followItemList, followShopList: followShopList, nickname: nickname, pickupItemList: pickupItemList, recentlyItem: recentlyItem, userPhoneNumber: userPhoneNumber)
    //            }
    //        } catch {
    //            print(error.localizedDescription)
    //        }
    //    }
    
    func updateUser(user: User) {
        Firestore.firestore().collection("User").document(user.id)
            .updateData(["email" : user.email,
                         "followItemList" : user.followItemList,
                         "followShopList" : user.followShopList,
                         "nickname" : user.nickname,
                         "pickupItemList" : user.pickupItemList,
                         "recentlyItem" : user.recentlyItem,
                         "userPhoneNumber" : user.userPhoneNumber,
                         "deviceToken" : user.deviceToken,
                         "socialLoginType" : user.socialLoginType])
        readUser(userId: user.email)
    }
    
    func deleteUser(userId: String) {
        Firestore.firestore().collection("User")
            .document(userId).delete()
    }
    
    /// email 중복확인 메소드
    func doubleCheckEmail(userEmail: String) {
        Firestore.firestore().collection("User")
            .whereField("email", isEqualTo: userEmail)
            .getDocuments { snapshot, error in
                if snapshot!.documents.isEmpty {
                    print("사용 가능한 이메일입니다.")
                    self.emailCheckStr = "사용 가능한 이메일입니다."
                    self.isShowingVerification = true
                } else {
                    print("중복된 이메일 입니다. 다른 이메일을 사용해주세요")
                    self.emailCheckStr = "중복된 이메일 입니다. 다른 이메일을 사용해주세요"
                    
                }
            }
        
        
    }
    
    // 북마크: 내가 저장한 바틀 추가하기
    func addFollowItemId(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["followItemList": FieldValue.arrayUnion([id])])
        readUser(userId: user.id)
    }
    
    // 북마크: 내가 저장한 바틀 삭제하기
    func deleteFollowItemId(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["followItemList": FieldValue.arrayRemove([id])])
        readUser(userId: user.id)
    }
    
    // 북마크: 내가 저장한 샵 추가하기
    func addFollowShopId(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["followShopList": FieldValue.arrayUnion([id])])
        readUser(userId: user.id)
    }
    
    // 북마크: 내가 저장한 샵 제거하기
    func deleteFollowShopId(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["followShopList": FieldValue.arrayRemove([id])])
        readUser(userId: user.id)
    }
    
    // 최근 본 상품
    func addRecentlyItem(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["recentlyItem": FieldValue.arrayUnion([id])])
        readUser(userId: user.id)
    }
    
    func getUserDataRealTime(userId: String) {
        
        Firestore.firestore().collection("User").document(userId).addSnapshotListener { documentSnapshot, error in
            guard let document = documentSnapshot else {
                print("Error fetching document: \(error!)")
                return
            }
            
            guard let currentData = document.data() else {
                   print("Document data was empty.")
                   return
                 }
            
            
            //            for document in document.documents {
            //                let currentData = document.data()
            let email: String = currentData["email"] as? String ?? ""
            let followItemList: [String] = currentData["followItemList"] as? [String] ?? []
            let followShopList: [String] = currentData["followShopList"] as? [String] ?? []
            let nickname: String = currentData["nickname"] as? String ?? ""
            let pickupItemList: [String] = currentData["pickupItemList"] as? [String] ?? []
            let recentlyItem: [String] = currentData["recentlyItem"] as? [String] ?? []
            let userPhoneNumber: String = currentData["userPhoneNumber"] as? String ?? ""
            let deviceToken: String = currentData["deviceToken"] as? String ?? ""
            let noticeList: [String] = currentData["noticeList"] as? [String] ?? []
            let socialLoginType: String = currentData["socialLoginType"] as? String ?? ""
            self.user = User(id: userId, email: email, followItemList: followItemList, followShopList: followShopList, nickname: nickname, pickupItemList: pickupItemList, recentlyItem: recentlyItem, userPhoneNumber: userPhoneNumber, deviceToken: deviceToken, noticeList: noticeList, socialLoginType: socialLoginType)
            //            }
            
            print("Current data: \(self.user)")
        }
        
    }
    
    func addUserReservation(reservationId: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["pickupItemList": FieldValue.arrayUnion([reservationId])])
        readUser(userId: user.id)
    }
    
    func addUserNoticeData(_ id: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["noticeList": FieldValue.arrayUnion([id])])
        getUserDataRealTime(userId: user.id)
//        readUser(userId: user.id)
    }
    
    func updateUserPhoneNumber(phoneNumber: String) {
        Firestore.firestore().collection("User")
            .document(user.id)
            .updateData(["userPhoneNumber": phoneNumber])
        readUser(userId: user.id)
    }
}

