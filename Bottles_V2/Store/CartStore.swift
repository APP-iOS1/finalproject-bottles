//
//  CartStore.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/06.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class CartStore: ObservableObject {
    
    @Published var carts: [Cart] = []
    @Published var totalPrice: Int = 0
    @Published var shopName: String = ""
    
    
    // MARK: - 장바구니 담기
    func createCart(cart: Cart, userEmail: String) {
        let database = Firestore.firestore()
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .document(cart.id)
            .setData(["bottleId" : cart.bottleId,
                      "eachPrice" : cart.eachPrice,
                      "itemCount" : cart.itemCount,
                      "shopId" : cart.shopId,
                      "shopName" : cart.shopName])
        readCart(userEmail: userEmail)
    }
    
    // MARK: - 장바구니 데이터 불러오기
    func readCart(userEmail: String) {
        let database = Firestore.firestore()
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .getDocuments { (snapshot, error) in
                
                self.carts.removeAll()
                self.totalPrice = 0
                if let snapshot {
                    for document in snapshot.documents {
                        let id: String = document.documentID
                        let docData = document.data()
                        let bottleId = docData["bottleId"] as? String ?? ""
                        let eachPrice = docData["eachPrice"] as? Int ?? 0
                        let itemCount = docData["itemCount"] as? Int ?? 0
                        let shopId = docData["shopId"] as? String ?? ""
                        let shopName = docData["shopName"] as? String ?? ""
                        
                        let cart = Cart(id: id, bottleId: bottleId, eachPrice: eachPrice, itemCount: itemCount, shopId: shopId, shopName: shopName)
                        
                        self.totalPrice += cart.eachPrice * cart.itemCount
                        self.carts.append(cart)
                    }
                    if self.carts.isEmpty {
                        self.shopName = ""
                    }
                    else {
                        self.shopName = self.carts[0].shopName
                    }
                    
                }
            }
    }
    
    // MARK: - 장바구니 업데이트
    func updateCart(cart: Cart, userEmail: String) {
        let database = Firestore.firestore()
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .document(cart.id)
            .updateData(["bottleId" : cart.bottleId,
                         "eachPrice" : cart.eachPrice,
                         "itemCount" : cart.itemCount,
                         "shopId" : cart.shopId,
                         "shopName" : cart.shopName])
        readCart(userEmail: userEmail)
    }
    
    // MARK: - 장바구니 바틀 삭제
    func deleteCart(cart: Cart, userEmail: String) {
        let database = Firestore.firestore()
                database.collection("User")
                    .document(userEmail)
                    .collection("Cart")
                    .document(cart.id).delete()
        readCart(userEmail: userEmail)
    }
    
    // MARK: - 장바구니 전체 삭제 후 다른 bottleShop 제품 담기
    func deleteAllCart(userEmail: String) {
        let database = Firestore.firestore()
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .getDocuments { (snapshot, error) in
                if let error = error {
                    print("Error getting documents: \(error)")
                    return
                }

                guard let snapshot = snapshot else { return }

                for document in snapshot.documents {
                    document.reference.delete { (error) in
                        if let error = error {
                            print("Error deleting document: \(error)")
                            return
                        }

                        print("Document successfully deleted")
                    }
                }
                
            }
        self.carts = []
        
    }
    
    // MARK: - 장바구니 수량 관리
    func manageItemCount(cart: Cart, userEmail: String, op: String) {
        let database = Firestore.firestore()
        if op == "+" {
            database.collection("User")
                .document(userEmail)
                .collection("Cart")
                .document(cart.id)
                .updateData(["bottleId" : cart.bottleId,
                             "eachPrice" : cart.eachPrice,
                             "itemCount" : cart.itemCount + 1,
                             "shopId" : cart.shopId,
                             "shopName" : cart.shopName])
            readCart(userEmail: userEmail)
        } else if op == "-" {
            database.collection("User")
                .document(userEmail)
                .collection("Cart")
                .document(cart.id)
                .updateData(["bottleId" : cart.bottleId,
                             "eachPrice" : cart.eachPrice,
                             "itemCount" : cart.itemCount - 1,
                             "shopId" : cart.shopId,
                             "shopName" : cart.shopName])
            readCart(userEmail: userEmail)
        }
    }
    
}
