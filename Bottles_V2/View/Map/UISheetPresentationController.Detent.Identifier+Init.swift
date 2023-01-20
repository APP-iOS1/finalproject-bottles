//
//  UISheetPresentationController.Detent.Identifier+Init.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import UIKit

@available(iOS 16.0, *)
public extension UISheetPresentationController.Detent.Identifier {

    /// A fraction-specific detent identifier.
    static func fraction(_ value: CGFloat) -> Self {
        .init("Fraction:\(String(format: "%.1f", value))")
    }

    /// A height-specific detent identifier.
    static func height(_ value: CGFloat) -> Self {
        .init("Height:\(value)")
    }
}
