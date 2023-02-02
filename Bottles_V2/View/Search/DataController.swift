//
//  DataController.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/02/02.
//

// CoreData Controller
// 최근 검색어 저장에 사용

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "SearchModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("Data saved")
        } catch {
            print("We could not save the data")
        }
    }
    
    func addSearchHistory(text: String, context: NSManagedObjectContext) {
        let searchHistory = SearchHistory(context: context)
        searchHistory.id = UUID()
        searchHistory.date = Date()
        searchHistory.text = text
        
        save(context: context)
    }
    
    func editSearchHistory(searchHistory: SearchHistory, text: String, context: NSManagedObjectContext) {
        searchHistory.date = Date()
        searchHistory.text = text
        
        save(context: context)
    }
}
