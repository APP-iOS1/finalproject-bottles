//
//  ShopStore.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/01/19.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

struct ShopModel : Codable, Identifiable {
    var id : String
    var shopName : String
    var shopOpenCloseTime : String
    var shopAddress : String
    var shopPhoneNumber : String
    var shopIntroduction : String
    var shopSNS : String
    var followerUserList : Array<String>
    var isRegister : Bool
    var location : GeoPoint
    var reservedList : Array<String>
    var shopTitleImage : String
    var shopImages : Array<String>
    var shopCurationTitle : String
    var shopCurationBody : String
    var shopCurationImage : String
    var shopCurationBottleID : Array<String>
    
    var bottleCollections : Array<String>
    var noticeCollection : Array<String>
    var reservationCollection : Array<String>
}

class ShopDataStore : ObservableObject {
    
    // 전체 샵 데이터 저장 변수
    @Published var shopData : [ShopModel] = []
    
    // 로그인 시 전체 패치 실행
    @MainActor
    func getAllShopData() async {
        
        do {
            let documents = try await Firestore.firestore().collection("Shop").getDocuments()
            for document in documents.documents {
                let docData = document.data()
                // 있는지를 따져서 있으면 데이터 넣어주고, 없으면 옵셔널 처리
                
                let id : String = document.documentID
                print("id \(id)")
                let shopName : String = docData["shopName"] as? String ?? ""
                print("shopName \(shopName)")
                let shopOpenCloseTime : String = docData["shopOpenCloseTime"] as? String ?? ""
                let shopAddress : String = docData["shopAddress"] as? String ?? ""
                let shopPhoneNumber : String = docData["shopPhoneNumber"] as? String ?? ""
                let shopIntroduction : String = docData["shopIntroduction"] as? String ?? ""
                let shopSNS : String = docData["shopSNS"] as? String ?? ""
                let followerUserList : Array<String> = docData["followerUserList"] as? Array<String> ?? ["no"]
                let isRegister : Bool = docData["isRegister"] as? Bool ?? true
                let location : GeoPoint = docData["location"] as? GeoPoint ?? GeoPoint(latitude: 0, longitude: 0)
                let reservedList : Array<String> = docData["reservedList"] as? Array<String> ?? ["no"]
                let shopTitleImage : String = docData["shopTitleImage"] as? String ?? ""
                let shopImages : Array<String> = docData["shopImages"] as? Array<String> ?? ["no"]
                let shopCurationTitle : String = docData["shopCurationTitle"] as? String ?? ""
                let shopCurationBody : String = docData["shopCurationBody"] as? String ?? ""
                let shopCurationImage : String = docData["shopCurationImage"] as? String ?? ""
                let shopCurationBottleID : Array<String> = docData["shopCurationBottleID"] as? Array<String> ?? ["no"]
                let bottleCollections : Array<String> = docData["BottleCollections"] as? Array<String> ?? ["no"]
                let noticeCollection : Array<String> = docData["NoticeCollection"] as? Array<String> ?? ["no"]
                let reservationCollection : Array<String> = docData["reservationCollection"] as? Array<String> ?? ["no"]
                
                let shopData : ShopModel = ShopModel(id: id, shopName: shopName, shopOpenCloseTime: shopOpenCloseTime, shopAddress: shopAddress, shopPhoneNumber: shopPhoneNumber, shopIntroduction: shopIntroduction, shopSNS: shopSNS, followerUserList: followerUserList, isRegister: isRegister, location: location, reservedList: reservedList, shopTitleImage: shopTitleImage, shopImages: shopImages, shopCurationTitle: shopCurationTitle, shopCurationBody: shopCurationBody, shopCurationImage: shopCurationImage, shopCurationBottleID: shopCurationBottleID, bottleCollections: bottleCollections, noticeCollection: noticeCollection, reservationCollection: reservationCollection)
                
                self.shopData.append(shopData)
                //                        print("우하하하 \(self.shopData)")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
