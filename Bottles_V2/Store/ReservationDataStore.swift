//
//  BottleDataStore.swift
//  Bottles_V2
//
//  Created by Jero on 2023/01/20.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

//MARK: - 예약 모델
struct ReservationModel : Codable, Identifiable {
    var id : String
    var shopId : String
    var userId : String      // 이메일 형식으로 들어옴
    var reservedTime : String
    var state: String
    var reservedBottles : [ReservedBottles]
}

//MARK: - 예약한 바틀 모델
struct ReservedBottles : Codable {
    var id : String
    var bottleId : String
    var itemCount : Int
}

//MARK: - 예약 데이터 스토어
class ResevationDataStore : ObservableObject {
    
    @Published var reservationData: [ReservationModel] = []
    @Published var reservedBottles: [ReservedBottles] = []
    
    let database = Firestore.firestore()

    //MARK: - 예약 등록
    func createReservation(reservationData: ReservationModel, reservedBottles: ReservedBottles, userEmail: String) {
        database.collection("Reservation")
            .document(userEmail)
            .collection("ReservedBottles")
            .document(reservedBottles.bottleId)
            .setData(["reservedTime" : reservationData.reservedTime,
                      "state" : reservationData.state,
                      "shopId" : reservationData.shopId,
                      "userId" : reservationData.userId])
//        getAllReservationData(userId: userId)
    }
    
    // MARK: - 예약 불러오기
    func getAllReservationData() async {
        
        do{
            let documents = try await Firestore.firestore().collection("Reservation").getDocuments()
            for document in documents.documents {
//                let reservedBottles = await self.getReservedBottls(snapshot: document)
                
                
                let id : String = document.documentID
                let shopID : String = document["shopName"] as? String ?? ""
                let userID : String = document["userID"] as? String ?? ""
                // 데이터 포멧을 위한 준비
                let timeStampData : Timestamp = document["TimeStampData"] as? Timestamp ?? Timestamp()
                let timeStampToDate : Date = timeStampData.dateValue()
                // 여기까지 사용 안함
                var reservedTime : String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko_kr")
                    dateFormatter.timeZone = TimeZone(abbreviation: "KST")
                    dateFormatter.dateFormat = "yyyy년 MM월 dd일" // "yyyy-MM-dd HH:mm:ss"
                    let dateCreatedAt = timeStampToDate
                    return dateFormatter.string(from: dateCreatedAt)
                }
                
//                self.resevationData.append(
//                    ReservationModel(
//                        id: id, shopId: shopId, userId: userId, reservedTime: reservedTime, reservedBottles: reservedBottles
//                    )
//                )
                
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    //MARK: - 예약 삭제
    func deleteReservation(reservationData: ReservationModel, reservedBottles: ReservedBottles, userEmail: String) {
        database.collection("Reservation")
            .document(userEmail)
            .collection("ReservedBottles")
            .document(reservedBottles.bottleId).delete()
//        getAllReservationData(userEmail: userEmail)
    }
    
    //MARK: - 예약한 바틀 등록
//    func createReservation(reservationData: ReservationModel, reservedBottles: ReservedBottles, userEmail: String) {
//        database.collection("Reservation")
//            .document(userEmail)
//            .collection("ReservedBottles")
//            .document(reservedBottles.bottleId)
//            .setData(["id" : reservedBottles.id,
//                      "bottleId" : reservedBottles.bottleId,
//                      "itemCount" : reservedBottles.itemCount])
//        getReservedBottls(userEmail: userEmail)
//    }
    
    //MARK: - 예약한 바틀 불러오기
    func getReservedBottls(snapshot: DocumentSnapshot) async -> [ReservedBottles] {
        var resultData: [ReservedBottles] = []
        
        do {
            let documents = try await snapshot.reference.collection("ReservedBottles").getDocuments()
            print(documents.documents)
            for document in documents.documents {
                resultData.append(ReservedBottles(
                    id: document.documentID,
                    bottleId: document["bottleId"] as? String ?? "",
                    itemCount: document["itemCount"] as? Int ?? 0
                ))
            }
            return resultData
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    //MARK: - 예약한 바틀 삭제
//    func deleteReservation(reservationData: ReservationModel, reservedBottles: ReservedBottles, userEmail: String) {
//        database.collection("Reservation")
//            .document(userEmail)
//            .collection("ReservedBottles")
//            .document(reservedBottles.bottleId).delete()
//        getAllReservationData(userEmail: userEmail)
//    }
    
}
