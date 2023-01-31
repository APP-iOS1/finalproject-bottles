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

class ShopDataStore : ObservableObject {
    @Published var shops: [Shop] = []
    
    // MARK: 모든 shop 리스트를 가져오는 비동기 함수
    @MainActor
    func fetchShopList() async {
        do {
            let shops = try await Amplify.DataStore.query(Shop.self)
            self.shops = shops
        } catch let error as DataStoreError {
            print("Error retrieving bottles \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }
    
    // MARK: shopData를 가져오는 함수
    /// Parameter
    /// shopId : shop의 고유 id
    func requestShopDataWithShopId(shopId: String) -> Shop{
        return shops.filter{$0.id == shopId}.first ?? Shop()
    }
    
    // MARK: follow한 shopList를 반환하는 함수
    /// Parameter
    /// followShopList : User가 갖고 있는 팔로우한 샵 리스트에 대한 [String]
    func requestFollowShopList(followShopList:[String]) -> [Shop]{
        var ret : [Shop] = []
        for shopID in followShopList{
            for shop in shops{
                if shopID == shop.id{
                    ret.append(shop)
                }
            }
        }
        return ret
    }
    
    // 
}
