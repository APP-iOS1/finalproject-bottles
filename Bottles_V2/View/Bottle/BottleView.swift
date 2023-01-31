//
//  BottleView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct BottleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // MARK: - 바틀 기본 정보 (바틀 이름, 가격, 바틀샵 이름)
                    BottleView_Info()
                    
                    // MARK: - 바틀 상세 정보
                    BottleView_Detail()
                    
                    // MARK: - 바틀샵 리스트
                    VStack(alignment: .leading) {
                        Text("이 상품의 다른 바틀샵")
                            .font(.bottles15)
                            .fontWeight(.bold)
                            
                        ForEach(0..<3, id: \.self) {_ in
                            NavigationLink {
                                BottleShopView()
                            } label: {
                                BottleView_ShopCell()
                            }
                        }
                    }
                    .padding()
                    
                    // MARK: - 예약하기 버튼
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 51)
                            Text("예약하기")
                                .modifier(AccentColorButtonModifier())
                        }
                    }
                    .padding()
                }
            }
            if isShowingSheet {
                ReservationView(isShowing: $isShowingSheet)
            }
        }
        // back button
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem (placement: .navigationBarLeading)  {
                Image("back")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        })
    }
}

//struct BottleView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView()
//    }
//}
