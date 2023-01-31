//
//  BookMarkView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

enum tapInfo : String, CaseIterable {
    case bottle = "저장한 상품"
    case shop = "저장한 바틀샵"
}

struct BookMarkView: View {
    // tap picker
    @State private var selectedPicker: tapInfo = .bottle
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    NavigationLink {
                        SearchView()
                    } label: {
                        SearchViewNavigationLabel()
                    }
                    CartViewNavigationLink()
                        .padding(.leading, 5)
                }
                animate()
                BookMarkTapView(bookMarkTap: selectedPicker)
            }
        }
    }
    
    // MARK: - Picker Animation 함수
    @ViewBuilder
    private func animate() -> some View {
        VStack {
            HStack {
                ForEach(tapInfo.allCases, id: \.self) { item in
                    VStack {
                        Text(item.rawValue)
                            .kerning(-1)
                            .frame(maxWidth: 200, maxHeight: 30)
                            .foregroundColor(selectedPicker == item ? .black : .gray)
                            .padding(.top, 10)
                        
                        if selectedPicker == item {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "info", in: animation)
                        } else if selectedPicker != item {
                            Capsule()
                                .foregroundColor(.white)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            self.selectedPicker = item
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
        }

    }
}


struct BookMarkTapView: View {
    var bookMarkTap: tapInfo
    var body: some View {
        VStack {
            switch bookMarkTap {
            case .bottle:
                BookMarkBottleList()
            case .shop:
                BookMarkShopList()
            }
        }
    }
}

struct BookMarkView_Previews: PreviewProvider {
    static var previews: some View {
        BookMarkView()
    }
}
