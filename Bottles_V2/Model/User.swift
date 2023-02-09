//
//  User.swift
//  Bottles_V2
//
//  Created by Ethan Choi on 2023/02/03.
//

import SwiftUI

struct User: Identifiable {
    
    let id: String
    let email: String
    let followItemList: [String]
    let followShopList: [String]
    let nickname: String
    let pickupItemList: [String]
    let recentlyItem: [String]
    let userPhoneNumber: String
    let deviceToken: String

}
