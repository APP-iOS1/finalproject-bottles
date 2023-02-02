//
//  SideButtonCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/02.
//

import SwiftUI
// MARK: - 맵뷰 사이드 셀 자리(북마크 & GPS 버튼)
struct SideButtonCell: View {
    
    @State var isBookMarkTapped: Bool = false
    
    var body: some View {
        VStack(spacing: -20) {
            Button {
                isBookMarkTapped.toggle()
            } label: {
                Image(isBookMarkTapped ? "Map_BookMark_tapped" : "Map_BookMark")
            }
            
            Button {
                //
            } label: {
                Image("Map_GPS")
            }
        }
    }
}

struct SideButtonCell_Previews: PreviewProvider {
    static var previews: some View {
        SideButtonCell()
    }
}
