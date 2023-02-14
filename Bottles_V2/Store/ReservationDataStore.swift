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

class ReservationDataStore : ObservableObject {
    
    @Published var reservationData: [ReservationModel] = []
    var reservedBottles: [ReservedBottles] = []
    
    // MARK: - 예약 등록
    func createReservation(reservationData: ReservationModel, reservedBottles: [BottleReservation]) async {
        do {
            let documents = Firestore.firestore().collection("Reservation")
            try await documents.document(reservationData.id)
                .setData(["reservedTime" : Date.now,
                          "state" : reservationData.state,
                          "shopId" : reservationData.shopId,
                          "userId" : reservationData.userId])
            
            await self.createReservedBottles(reservedBottles: reservedBottles, reservationId: reservationData.id)
            await readReservation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - 예약 불러오기
    @MainActor
    func readReservation() async {
        reservationData.removeAll()
        do{
            let documents = try await Firestore.firestore().collection("Reservation").getDocuments()
            for document in documents.documents {
                let reservedBottles = await self.readReservedBottles(snapshot: document)
                
                let id : String = document.documentID
                let shopId : String = document["shopId"] as? String ?? ""
                let userId : String = document["userId"] as? String ?? ""
                let state : String = document["state"] as? String ?? ""
                // 데이터 포멧을 위한 준비
                let timeStampData : Timestamp = document["reservedTime"] as? Timestamp ?? Timestamp()
                let timeStampToDate : Date = timeStampData.dateValue()
                // 여기까지 사용 안함
                var reservedTime : String {
                    let dateFormatter = DateFormatter()
                    dateFormatter.locale = Locale(identifier: "ko_kr")
                    dateFormatter.timeZone = TimeZone(abbreviation: "KST")
                    dateFormatter.dateFormat = "yyyy.MM.dd" // "yyyy-MM-dd HH:mm:ss"
                    let dateCreatedAt = timeStampToDate
                    return dateFormatter.string(from: dateCreatedAt)
                }
                
                self.reservationData.append(
                    ReservationModel(
                        id: id, shopId: shopId, userId: userId, reservedTime: reservedTime, state: state, reservedBottles: reservedBottles)
                )
                
            }
            print(reservationData)
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
//    // MARK: - 예약 삭제
//    func deleteReservation(reservationData: ReservationModel) async {
//        do {
//            let documents = Firestore.firestore().collection("Reservation")
//            try await documents.document(reservationData.id).delete()
//            await readReservation()
//        } catch {
//            print(error.localizedDescription)
//        }
//    }
    
    // MARK: - 예약한 바틀 등록
    func createReservedBottles(reservedBottles: [BottleReservation], reservationId: String) async {
        do {
            let documents = Firestore.firestore().collection("Reservation")
            for reservedBottle in reservedBottles {
                try await documents.document(reservationId).collection("ReservedBottles").document(UUID().uuidString)
                    .setData(["bottleId" : reservedBottle.id,
                              "itemCount" : reservedBottle.count])
            }
//            await readReservation()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    // MARK: - 예약한 바틀 불러오기
    func readReservedBottles(snapshot: DocumentSnapshot) async -> [ReservedBottles] {
        var resultData: [ReservedBottles] = []
        
        do {
            let documents = try await snapshot.reference.collection("ReservedBottles").getDocuments()
            print(documents.documents)
            for document in documents.documents {
                resultData.append(ReservedBottles(
                    id: document.documentID,
                    BottleId: document["bottleId"] as? String ?? "",
                    itemCount: document["itemCount"] as? Int ?? 0
                ))
            }
            return resultData
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
    
    func cancelReservation (reservationId: String) async {
        
        do {
            let documents = Firestore.firestore().collection("Reservation")
            try await documents
                .document(reservationId)
                .updateData(["state": "예약취소"])
            await readReservation()
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
}
