//
//  DataStore.swift
//  awsConnetTest
//
//  Created by jina on 2023/01/16.
//

import Foundation
import Amplify
import AWSDataStorePlugin
import SwiftUI
import Combine

/*
 //User 데이터로 들어오는 Model 구조 -> AmplifyModel 폴더 하위에서 볼 수 있음
 type User @model @auth(rules: [{allow: public}]) {
 id: ID!
 email: String
 followShopList: [String]
 recentlyItem: [String]
 followItemList: [String]
 pickupItemList: [String]
 userPhoneNumber: [AWSPhone]
 recentlySearch: String
 }
 */


// User 데이터를 받아올 때는 로그인, 팔로우여부, 검색 등 행동 시에만 갱신되고, 한번 저장된 데이터는 published로 앱 내에서 저장하도록 함.
class UserDataStore : ObservableObject {
    
    // User별 세부 데이터를 저장하는 변수
    @Published var user: User?
    
    
    
    // MARK: 로그인된 User의 Email을 기반으로 하위 데이터를 전체 가져오는 함수
    /// Parameter
    /// - userEmail : 유저의 이메일
    // TODO: 목업 이메일 데이터 수정
    @MainActor
    func fetchUserWithEmail(userEmail : String) async {
        let user = User.keys
        do {
            self.user = try await Amplify.DataStore.query(
                User.self,
                where: user.email == "test@naver.com").first
//            self.user = try await Amplify.DataStore.query(User.self, where: User.keys.email == userEmail).first
            print("미지 id있나 \(user.id)")
        } catch let error as DataStoreError {
            print("Error listing posts - \(error.localizedDescription)")
        } catch {
            print("Unexpected error \(error.localizedDescription)")
        }
    }
    
    
    // MARK: - DB에서 삭제하는 코드.
    /// Parameter
    ///  - user : 로그인을 통해 승인된 유저
    // TODO: Auth에서 삭제하는 코드는 별도로 작업 필요함
    func deleteUser(user: AuthUser) async {
        do {
            try await Amplify.DataStore.delete(User(id: user.userId))
            /*
             Auth에서 삭제하는 코드 작성 부분
             */
            print("삭제 완료")
        } catch let error as DataStoreError {
            print("Error deleting item: \(error)")
        } catch {
            print("Unexpected error: \(error)")
        }
    }
    
    
    func updateRecentlyBottle(bottleId: String) async {
        
        var existingUser: User = self.user ?? User()
        existingUser.recentlyBottles?.append(bottleId)
        
        do {
            try await Amplify.DataStore.save(existingUser)
            print("Updated the existing post")
        } catch let error as DataStoreError {
            print("Error updating post - \(error)")
        } catch {
            print("Unexpected error \(error)")
        }
        
        
    }
}


/*
 
 //모든 User의 원하는 세부 정보를 전체 다 가져오는 쿼리
 func getAllUser() async {
 do {
 let users = try await Amplify.DataStore.query(User.self)
 for item in users {
 print("User ID: \(item.id)")
 }
 } catch let error as DataStoreError {
 print("Error querying items: \(error)")
 } catch {
 print("Unexpected error: \(error)")
 }
 }
 
 //User id별로 개인별 데이터 불러오기 가능
 func getLogindedUser() async {
 do {
 let users = try await Amplify.API.query(request: .get(User.self, byId: "cfe212a1-6eaa-4733-ad9e-f167d6fccadf"))
 switch users {
 case .success(let todo):
 guard let todo = todo else {
 print("Could not find todo")
 return
 }
 print("Successfully retrieved todo: \(todo)")
 case .failure(let error):
 print("Got failed result with \(error.errorDescription)")
 }
 } catch let error as APIError {
 print("Failed to query todo: ", error)
 } catch {
 print("Unexpected error: \(error)")
 }
 }
 
 
 */


