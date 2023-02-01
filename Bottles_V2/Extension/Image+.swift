//
//  Image+.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/01.
//

import Foundation
import SwiftUI

    //MARK: -  MainLoginVeiw의 소셜로그인 이미지 사이즈 조절에 대한 image extesion
extension Image {
    /// MainLoginView의 소셜 로그인 버튼 이미지 사이즈 조절
    func socialLoginImageModifier() -> some View {
        self
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 48)
    }
}
