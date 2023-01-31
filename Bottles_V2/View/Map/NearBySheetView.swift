//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

// MARK: - 둘러보기 디테일 뷰
struct NearBySheetView: View {
    // 테스트용 모델
    @StateObject var bookMarkTestStore: BookMarkTestStore = BookMarkTestStore()
    var body: some View {
        NavigationStack {
            HStack(alignment: .top) {
                Text("둘러보기")
                    .font(.bottles20)
                    .bold()
                    .padding(.leading, 15)
                Spacer()
            }
            
            VStack {
                BookMarkShopListCell(shopInfo: bookMarkTestStore.BookMarkShops[0])
            }
            Spacer()
        }
    }
}

struct NearBySheetView_Previews: PreviewProvider {
    static var previews: some View {
        NearBySheetView()
    }
}
