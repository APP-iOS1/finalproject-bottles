//
//  BottleDataStore.swift
//  Bottles_V2
//
//  Created by Jero on 2023/01/20.
//

import Foundation
import Amplify
import AWSDataStorePlugin
import SwiftUI
import Combine

class BottleDataStore : ObservableObject {
    @Published var bottles: [Bottle] = []
    
    func getData() async {
        do {
            let bottle = try await Amplify.DataStore.query(Bottle.self)
            print("bottles: \(bottle)")
            self.bottles = bottle
        } catch let error as DataStoreError {
            print("Error retrieving bottles \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }
    
    func searchBottleData(_ name: String) async {
        do {
            let bottle = try await Amplify.DataStore.query(Bottle.self, where: Bottle.keys.itemName.contains(name))
            print("bottles: \(bottle)")
            self.bottles = bottle
        } catch let error as DataStoreError {
            print("Error retrieving bottles \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }
    
    func putData() async {
        
    }
    
    // MARK: - User의 followItemList 배열에 존재하는 itemID와 일치하는 bottle들을 가져오기. 사용되는 곳으로는 BookMarkBottleList가 있습니다.
    /// Parameter: likeItemList는 User가 좋아하는 바틀 아이템 리스트입니다
    func fetchFollowItemList(likeItemList: [String]) -> [Bottle]{
        var ret:[Bottle] = []
        for likeItem in likeItemList{
            for bottle in bottles{
                if likeItem == bottle.id{
                    ret.append(bottle)
                }
            }
        }
        return ret
    }
    
    
}
