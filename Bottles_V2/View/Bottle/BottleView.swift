//
//  BottleView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

// MARK: - 바틀 정보
/// 바틀의 정보 및 해당 바틀을 판매하는 바틀샵 리스트를 표시하는 뷰입니다.
struct BottleView: View {
    @EnvironmentObject var userDataStore : UserDataStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // 바틀 기본 정보 (바틀 이미지, 바틀 이름, 북마크, 바틀 가격, 바틀샵 이름)
                    BottleView_Info()
                    
                    // Tasting Notes, Information, Pairing
                    BottleView_Detail()
                    
                    // 해당 바틀을 판매하는 바틀샵 리스트
                    VStack(alignment: .leading) {
                        Text("이 상품의 다른 바틀샵")
                            .font(.bottles15)
                            .fontWeight(.bold)
                            
                        ForEach(0..<3, id: \.self) {_ in
                            NavigationLink {
                                // 바틀샵 뷰로 이동
                                BottleShopView()
                            } label: {
                                // 바틀샵 셀
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
            
            // 예약하기 버튼 클릭 시 예약하기 뷰 present
            ReservationView(isShowing: $isShowingSheet)
        }
        // back button
//        .navigationBarBackButtonHidden(true)
//        .toolbar(content: {
//            ToolbarItem (placement: .navigationBarLeading)  {
//                Image("back")
//                    .onTapGesture {
//                        self.presentationMode.wrappedValue.dismiss()
//                    }
//            }
//        })
        .toolbar(.hidden, for: .tabBar)
    }
}

//struct BottleView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView()
//    }
//}
