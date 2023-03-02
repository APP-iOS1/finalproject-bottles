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

class BottleDataStore : ObservableObject {
    
    @Published var bottleData : [BottleModel] = []
    
    func getAllBottleData() async {
        
        Firestore.firestore().collection("Bottle")
            .getDocuments { (snapshot, error) in
                self.bottleData.removeAll()
                
                if let snapshot {
                    print("스냅샷 있음 \(snapshot)")
                    for document in snapshot.documents {
                        let docData = document.data()
                        // 있는지를 따져서 있으면 데이터 넣어주고, 없으면 옵셔널 처리
                        
                        let id : String = document.documentID
                        print("id \(id)")
                        let shopID : String = docData["shopID"] as? String ?? ""
                        let shopName : String = docData["shopName"] as? String ?? ""
                        let itemVarities : Array<String> = docData["itemVarities"] as? Array<String> ?? ["no"]
                        let itemType : String = docData["itemType"] as? String ?? ""
                        let itemTaste : String = docData["itemTaste"] as? String ?? ""
                        let itemTag : Array<String> = docData["itemTag"] as? Array<String> ?? ["no"]
                        let itemProducer : String = docData["itemProducer"] as? String ?? ""
                        let itemPrice : Int = docData["itemPrice"] as? Int ?? 0
                        let itemPairing : String = docData["itemPairing"] as? String ?? ""
                        let itemNation : String = docData["itemNation"] as? String ?? ""
                        let itemName : String = docData["itemName"] as? String ?? ""
                        let itemML : Int = docData["itemML"] as? Int ?? 0
                        let itemImage : String = docData["itemImage"] as? String ?? ""
                        let itemFinish : String = docData["itemFinish"] as? String ?? ""
                        let itemDegree : Float = docData["itemDegree"] as? Float ?? 0.0
                        let itemAroma : String = docData["itemAroma"] as? String ?? ""
                        let itemAdv : Float = docData["itemAdv"] as? Float ?? 0.0
                        
                        let shopData : BottleModel = BottleModel(id: id, shopID: shopID, shopName: shopName, itemVarities: itemVarities, itemType: itemType, itemTaste: itemTaste, itemTag: itemTag, itemProducer: itemProducer, itemPrice: itemPrice, itemPairing: itemPairing, itemNation: itemNation, itemName: itemName, itemML: itemML, itemImage: itemImage, itemFinish: itemFinish, itemDegree: itemDegree, itemAroma: itemAroma, itemAdv: itemAdv)
                        
                        self.bottleData.append(shopData)
//                        print("우하하하 \(self.bottleData)")
                    }
                }
            }
    }
    
    // MARK: - 북마크된 Bottle들을 가져오는 함수
    func filterUserBottleData(followItemList: [String]) -> [BottleModel] {
        var resultData: [BottleModel] = []
        
        for itemList in followItemList {
            let filterData = self.bottleData.filter {$0.id == itemList}[0]
            resultData.append(filterData)
        }
        
        return resultData
    }
    
    // MARK: - 검색 결과를 필터링해주는 함수
    func bottleSearchResult(bottleName: String) -> [BottleModel] {
        return self.bottleData.filter {
            $0.itemName.contains(bottleName)
        }
    }
}
