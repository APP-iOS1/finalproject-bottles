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

struct ResevationModel : Codable, Identifiable {
    var id : String
    var shopID : String
    var userID : String      // 이메일 형식으로 들어옴
    var reservedTime : String
    var reservedBottles : [ReservedBottles]
}

struct ReservedBottles : Codable {
    var id : String
    var BottleID : String
    var itemCount : Int
}

class ResevationDataStore : ObservableObject {
    
    @Published var resevationData : [ResevationModel] = []
    
    
    func getAllResevationData() async {
        
        do{
            let documents = try await Firestore.firestore().collection("Reservation").getDocuments()
            for document in documents.documents {
                let reservedBottles = await self.getReservedBottls(snapshot: document)
                
                
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
                
                self.resevationData.append(
                    ResevationModel(
                        id: id, shopID: shopID, userID: userID, reservedTime: reservedTime, reservedBottles: reservedBottles
                    )
                )
                
                print("나와라라ㅏㅏ \(self.resevationData)")
            }
            
        } catch {
            print(error.localizedDescription)
        }
        
    }
    
    
    func getReservedBottls(snapshot: DocumentSnapshot) async -> [ReservedBottles] {
        var resultData: [ReservedBottles] = []

        do {
            let documents = try await snapshot.reference.collection("ReservedBottles").getDocuments()
            print(documents.documents)
            for document in documents.documents {
                resultData.append(ReservedBottles(
                    id: document.documentID,
                    BottleID: document["BottleID"] as? String ?? "",
                    itemCount: document["itemCount"] as? Int ?? 0
                ))
            }
            return resultData
        } catch {
            print(error.localizedDescription)
        }
        return []
    }
}
