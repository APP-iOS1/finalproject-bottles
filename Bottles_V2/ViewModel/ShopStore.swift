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

do {
    let item = Shop(
        shopName: "Lorem ipsum dolor sit amet",
        shopAddress: "Lorem ipsum dolor sit amet",
        longitude: 123.45F,
        latitude: 123.45F,
        shopPhoneNumber: "(555) 123-6789",
        shopIntroduction: "Lorem ipsum dolor sit amet",
        registration: true,
        Bottles: [],
        followerUserList: [],
        shopGrade: 123.45F,
        ShopNotices: [],
        shopOpenCloseTime: [],
        shopImage: [],
        shopSNS: "Lorem ipsum dolor sit amet",
        shopTitleImage: "Lorem ipsum dolor sit amet",
        shopCuration: /* Provide a Curation instance here */)
    let savedItem = try await Amplify.DataStore.save(item)
    print("Saved item: \(savedItem)")
} catch let error as DataStoreError {
    print("Error creating item: \(error)")
} catch {
    print("Unexpected error: \(error)")
}

struct ShopStore: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct ShopStore_Previews: PreviewProvider {
    static var previews: some View {
        ShopStore()
    }
}
