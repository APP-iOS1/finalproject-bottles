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

class DataStore : ObservableObject {
    
    func getDate() async {
        do {
            let posts = try await Amplify.DataStore.query(User.self)
            print("Posts retrieved successfully: \(posts)")
            let result1 = posts.description
            
            print("결과1 \(result1)")
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
        let post = User(id: "hihi", email: "hihi@naver.com")
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
