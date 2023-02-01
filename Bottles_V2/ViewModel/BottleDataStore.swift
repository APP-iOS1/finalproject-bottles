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
    @Published var bottles2: [Bottle] = []
    
    //MARK: bottle의 리스트를 데이터베이스에서 불러오는 함수
    @MainActor
    func fetchBottleList() async {
        do {
            let bottle = try await Amplify.DataStore.query(Bottle.self)
//            print("bottles: \(bottle)")
            self.bottles = bottle
        } catch let error as DataStoreError {
            print("Error retrieving bottles \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }
    
    // MARK: User의 followItemList 배열에 존재하는 itemID와 일치하는 bottle들을 가져오기. 저장한 상품에서 상품들을 보여주는데 쓰입니다.
    /// Parameter: likeItemList는 User가 좋아하는 바틀 아이템 리스트입니다
    func requestFollowItemList(likeItemList: [String?]) async {
        var ret: [Bottle] = []
        do {
            for likeItem in likeItemList {
                let bottle = try await Amplify.DataStore.query(Bottle.self, where: Bottle.keys.id == likeItem)
//                print(bottle)
                ret.append(contentsOf: bottle)
            }
            self.bottles2 = ret
            
        } catch let error as DataStoreError {
            print("Error retrieving bottles \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
        
//        self.bottles = ret
//        return ret
    }
    
    
    
    
}
