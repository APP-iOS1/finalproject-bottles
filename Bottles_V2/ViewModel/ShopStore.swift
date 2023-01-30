//
//  ShopStore.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/01/19.
//

import Foundation
import Amplify
import AWSDataStorePlugin
import SwiftUI
import Combine

class ShopStore : ObservableObject {
    @Published var shop: [Shop]?
    @State var subscription: AnyCancellable?
    
    func getData() async {
        do {
            let shops = try await Amplify.DataStore.query(Shop.self)
            print("Posts retrieved successfully: \(shops)")
            let result1 = shops.description
            print("결과1 \(result1)")
            self.shop = shops
        } catch let error as DataStoreError {
            print("Error retrieving posts \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }

    // Query
    func queryShop() async {
        do {
            let items = try await Amplify.DataStore.query(Shop.self)
            for item in items {
                print("Shop ID: \(item.id)")
            }
        } catch let error as DataStoreError {
            print("Error querying items: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
}
