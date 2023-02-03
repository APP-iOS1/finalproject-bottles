//
//  Text+.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/02/03.
//

import Foundation
import SwiftUI

// MARK: - 특정 범위 텍스트 컬러 설정
/// 사용자의 검색어와 동일한 텍스트의 컬러를 바꿔주기 위한 Extension
extension Text {
    init(_ string: String, configure: ((inout AttributedString) -> Void)) {
        var attributedString = AttributedString(string) /// create an `AttributedString`
        configure(&attributedString) /// configure using the closure
        self.init(attributedString) /// initialize a `Text`
    }
}
