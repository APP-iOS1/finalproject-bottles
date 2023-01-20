//
//  UndimmedPresentationDetent.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import SwiftUI

import SwiftUI

/**
 This is used to bridge the SwiftUI `PresentationDetent`with
 the UIKit `UISheetPresentationController.Detent.Identifier`.
 */
@available(iOS 16.0, *)
public enum UndimmedPresentationDetent {

    /// The system detent for a sheet at full height.
    case large

    /// The system detent for a sheet that's approximately half the available screen height.
    case medium

    /// A custom detent with the specified fractional height.
    case fraction(_ value: CGFloat)

    ///  A custom detent with the specified height.
    case height(_ value: CGFloat)

    var swiftUIDetent: PresentationDetent {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case .fraction(let value): return .fraction(value)
        case .height(let value): return .height(value)
        }
    }

    var uiKitIdentifier: UISheetPresentationController.Detent.Identifier {
        switch self {
        case .large: return .large
        case .medium: return .medium
        case .fraction(let value): return .fraction(value)
        case .height(let value): return .height(value)
        }
    }
}

@available(iOS 16.0, *)
extension Collection where Element == UndimmedPresentationDetent {

    var swiftUISet: Set<PresentationDetent> {
        Set(map { $0.swiftUIDetent })
    }
}
