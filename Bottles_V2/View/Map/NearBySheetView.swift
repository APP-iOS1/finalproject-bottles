//
//  NearBySheetView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct NearBySheetView: View {
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
//                NearBySheetCell()
                    BookMarkShopListCell()
            }
            Spacer()
        }
//        .background(Color.white)
    }
}

struct NearBySheetView_Previews: PreviewProvider {
    static var previews: some View {
        NearBySheetView()
    }
}
