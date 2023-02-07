//
//  SideButtonCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/02/02.
//

import SwiftUI
// MARK: - 맵뷰 사이드 셀 자리(북마크 & GPS 버튼)
struct SideButtonCell: View {
    @StateObject var mapViewModel: MapViewModel
    @State var isBookMarkTapped: Bool = false
    @Binding var userLocation: (Double, Double)
    
    var body: some View {
        VStack(spacing: -20) {
            Button {
                isBookMarkTapped.toggle()
            } label: {
                Image(isBookMarkTapped ? "Map_BookMark_tapped" : "Map_BookMark")
            }
            
            Button {
                mapViewModel.coord = mapViewModel.userLocation
                // current Coordinate -> mapViewModel 설정
                print("userLocation : \(userLocation)")
            } label: {
                Image("Map_GPS")
            }
        }
    }
}

//struct SideButtonCell_Previews: PreviewProvider {
//    static var previews: some View {
//        SideButtonCell()
//    }
//}
