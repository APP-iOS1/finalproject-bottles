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
}
