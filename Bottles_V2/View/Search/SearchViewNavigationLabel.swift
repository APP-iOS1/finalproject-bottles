//
//  SearchViewNavigationLabel.swift
//  Bottles_V2
//
//  Created by 서찬호 on 2023/01/18.
//

import SwiftUI

// BookMarkView에서 사용하는 SearchView로 이동하는 버튼 라벨
struct SearchViewNavigationLabel: View {
    var body: some View {
        HStack {
            HStack {
                Text("원하는 술, 바틀샵 검색")
                    .font(.bottles16)
                    .foregroundColor(.black)
                    .padding(.leading, 5)
                Spacer()
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.black)
                    .font(.system(size: 18))
                    .padding(.trailing, 5)
            }
            .padding(10)
            .frame(width: 294, height: 52, alignment: .leading)
            .background{
                Color.gray_f7
            }
            .cornerRadius(12)
        }
    }
}
struct SearchViewNavigationLabel_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewNavigationLabel()
    }
}
