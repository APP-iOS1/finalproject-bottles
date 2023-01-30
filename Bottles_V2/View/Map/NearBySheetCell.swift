//
//  NearBySheetCell.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct NearBySheetCell: View {
    var body: some View {
        NavigationStack {
            HStack {
                AsyncImage(url: /*@START_MENU_TOKEN@*/URL(string: "https://example.com/icon.png")/*@END_MENU_TOKEN@*/) { image in
                    image
                        .resizable()
                } placeholder: {
                    ProgressView()
                }
                VStack(alignment: .leading) {
                    Text("바틀샵 이름")
                        .font(.bottles20)
                        .bold()
                    Text("한 줄 소개 내추럴 와인 포트와인 위스키 럼 꼬녁")
                        .font(.bottles12)
                }
            }
        }
    }
}

struct NearBySheetCell_Previews: PreviewProvider {
    static var previews: some View {
        NearBySheetCell()
    }
}
