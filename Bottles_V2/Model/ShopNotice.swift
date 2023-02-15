//
//  ShopNotice.swift
//  Bottles_V2
//
//  Created by Jero on 2023/02/09.
//

import Foundation

struct ShopNotice : Codable, Identifiable, Hashable, TestProtocol {
    var classification: String = "공지사항"
    var shopId: String = ""
    var userId: String = ""
    var reservedTime: Date = Date()
    var state: String = ""
    
    var id : String
    var category : String
    var shopName : String
    var date : Date
    var title : String
    var body: String
    
    func calculateTime() -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "M월 d일"
        return getTimeName(Int(Date().timeIntervalSince(date)), format.string(from: date))
    }
    
    func getTimeName(_ time: Int, _ date: String) -> String {
        let result = time / 60
        switch result {
        case 0:
            return "방금"
        case 1 ... 59:
            return "\(result)분 전"
        case 60 ... 1439:
            return "\(result / 60)시간 전"
        default:
            return date
        }
    }
    
}
