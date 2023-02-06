//
//  CartStore.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/06.
//

import Foundation
import FirebaseFirestore

class CartStore: ObservableObject {
    
    @Published var carts: [Cart] = []
    
    let database = Firestore.firestore()
    
    func createCart(cart: Cart, userEmail: String) {
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .document(cart.id)
            .setData(["id" : cart.id,
                      "bottleId" : cart.bottleId,
                      "eachPrice" : cart.eachPrice,
                      "itemCount" : cart.itemCount,
                      "shopId" : cart.shopId,
                      "shopName" : cart.shopName])
        readCart(userEmail: userEmail)
    }
    
    func readCart(userEmail: String) {
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .getDocuments { (snapshot, error) in
                
                self.carts.removeAll()
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
                        self.carts.append(cart)
                    }
                }
            }
    }
    
    func updateCart(cart: Cart, userEmail: String) {
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .document(cart.id)
            .updateData(["id" : cart.id,
                         "bottleId" : cart.bottleId,
                         "eachPrice" : cart.eachPrice,
                         "itemCount" : cart.itemCount,
                         "shopId" : cart.shopId,
                         "shopName" : cart.shopName])
        readCart(userEmail: userEmail)
    }
    
    func deleteCart(cart: Cart, userEmail: String) {
        database.collection("User")
            .document(userEmail)
            .collection("Cart")
            .document(cart.id).delete()
    }
    
    func deleteAllCart(userEmail: String) {
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
    }
    
}
