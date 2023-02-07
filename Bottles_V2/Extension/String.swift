//
//  String.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/07.
//

import Foundation

extension String {
    subscript(_ index: Int) -> Character {
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}
