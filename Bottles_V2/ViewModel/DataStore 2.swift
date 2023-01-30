//
//  DataStore.swift
//  awsConnetTest
//
//  Created by dev on 2023/01/16.
//

import Foundation
import Amplify
import AWSDataStorePlugin
import SwiftUI
import Combine

class DataStore : ObservableObject {
    @Published var user: [User]?
    @State var subscription: AnyCancellable?
    
//    func subscribeTodos() {
//       self.subscription
//           = Amplify.DataStore.publisher(for: User.self)
//               .sink(receiveCompletion: { completion in
//                   print("Subscription has been completed: \(completion)")
//               }, receiveValue: { mutationEvent in
//                   print("Subscription got this value: \(mutationEvent)")
//               })
//    }
    
//    func queryTodo() {
//
//            Amplify.DataStore.query(User.self, completion: { result in
//                switch(result) {
//                case .success(let users):
//                    for user in users {
//                        print("==== email ====")
//                        print("email: \(user.email)")
//                        if let email = user.email {
//                            print("Priority: \(email)")
//                        }
//
//                    }
//                case .failure(let error):
//                    print("Could not query DataStore: \(error)")
//                }
//            })
//        }
    
//    func observe(email: String) {
//            self.subscription = Amplify.Publisher.create(
//                Amplify.DataStore.observeQuery(
//                    for: User.self,
//                    where: User.keys.email == email
//                )
//            )
//            .sink { completion in
//                print("Completion event: \(completion)")
//            } receiveValue: { snapshot in
//                guard let user = snapshot.items.first else {
//                    return
//                }
//                print("user \(user)")
//                DispatchQueue.main.async {
//                    self.user = user
//                    print(user)
//                }
//            }
//        }
    
    func getDate() async {
        do {
            let users = try await Amplify.DataStore.query(User.self)
            print("Posts retrieved successfully: \(users)")
            let result1 = users.description
            print("결과1 \(result1)")
            self.user = users
        } catch let error as DataStoreError {
            print("Error retrieving posts \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
        
        //        do {
        //            let items = tery await Amplify.DataStore.query(User.self)
        //            for item in items {
        //                print("User ID: \(item.id)")
        //                print("User ID: \(item.email)")
        //            }
        //        } catch let error as DataStoreError {
        //            print("Error querying items: \(error)")
        //        } catch {
        //            print("Unexpected error: \(error)")
        //        }
    }
    
    func putData() async {
        let post = User(id: "testMizy", email: "testMizy@naver.com")
        do {
            try await Amplify.DataStore.save(post)
            print("Post saved successfully!")
        } catch let error as DataStoreError {
            print("Error saving post \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
    }
}

/*
 
 //creat
 do {
 let item = User(
 email: "Lorem ipsum dolor sit amet")
 let savedItem = try await Amplify.DataStore.save(item)
 print("Saved item: \(savedItem)")
 } catch let error as DataStoreError {
 print("Error creating item: \(error)")
 } catch {
 print("Unexpected error: \(error)")
 }
 //update
 do {
 let updatedItem = try await Amplify.DataStore.save(item)
 print("Updated item: \(updatedItem)")
 } catch let error as DataStoreError {
 print("Error updating item: \(error)")
 } catch {
 print("Unexpected error: \(error)")
 }
 //delete
 do {
 try await Amplify.DataStore.delete(itemToDelete)
 print("Deleted item: \(itemToDelete.identifier)")
 } catch let error as DataStoreError {
 print("Error deleting item: \(error)")
 } catch {
 print("Unexpected error: \(error)")
 }
 //query
 do {
 let items = try await Amplify.DataStore.query(User.self)
 for item in items {
 print("User ID: \(item.id)")
 }
 } catch let error as DataStoreError {
 print("Error querying items: \(error)")
 } catch {
 print("Unexpected error: \(error)")
 }
 */
