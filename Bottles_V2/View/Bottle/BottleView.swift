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
    //@EnvironmentObject private var path: Path
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @State private var isShowingSheet: Bool = false
    @State private var isShowingFillBookmarkMessage: Bool = false
    @State private var isShowingEmptyBookmarkMessage: Bool = false
    
    var bottleData: BottleModel
    
    func filteredBottleItem() -> [BottleModel] {
        return bottleDataStore.bottleData.filter { $0.id != bottleData.id && $0.itemName == bottleData.itemName }
    }
//
    func filteredShopItem(_ shopID: String) -> ShopModel {
        // 다른 바틀샵의 이 상품
        // 1. 현재 바틀이랑 동일한 이름을 filter한다.
        // 2. 그리고 바틀 데이터 안에서 bottleData에서 받은 shopName과 다른 shopName 사용하기
        return shopDataStore.shopData.filter { $0.id == shopID }[0]
    }
    
    var body: some View {

        NavigationStack {
            ZStack {
                VStack {
                    ScrollView {
                        // 바틀 기본 정보 (바틀 이미지, 바틀 이름, 북마크, 바틀 가격, 바틀샵 이름)
                        BottleView_Info(
                            isShowingFillBookmarkMessage: $isShowingFillBookmarkMessage,
                            isShowingEmptyBookmarkMessage: $isShowingEmptyBookmarkMessage,
                            bottleData: bottleData
                        )
                        
                        // Tasting Notes, Information, Pairing
                        BottleView_Detail(bottleData: bottleData)
                        
                        // 해당 바틀을 판매하는 바틀샵 리스트
                        VStack(alignment: .leading) {
                            if filteredBottleItem().count > 0 {
                                Text("다른 바틀샵의 이 상품")
                                    .font(.bottles18)
                                    .fontWeight(.medium)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            ForEach(filteredBottleItem()) { bottle in
                                NavigationLink {
                                    // 바틀 뷰로 이동
                                    BottleShopView(bottleShop: filteredShopItem(bottle.shopID))
                                } label: {
                                    // 바틀 셀
                                    BottleView_BottleCell(bottleData: bottle)
                                }
                            }
                        }
                        .padding()
                        
                        // MARK: - 예약하기 버튼
                    }
                    .onAppear {
                        userStore.addRecentlyItem(bottleData.id)
                    }
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 12)
                                .frame(width: 358, height: 56)
                            Text("예약하기")
                                .modifier(AccentColorButtonModifier())
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 5)
                    .padding(.bottom, 30)
                }
                
                // MARK: - "BookMark 완료"시 애니메이션
                if isShowingFillBookmarkMessage {
                    HStack{
                        Image("BookMark.fill")
                        Text("북마크가 완료되었습니다.")
                            .foregroundColor(.black)
                            .font(.bottles11)
                        
                    }
                    .zIndex(1)
                    .transition(.opacity.animation(.easeIn))
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 30)
                            .foregroundColor(.gray_f7)
                    }
                    .offset(y: 300)
                }
                
                // MARK: - "BookMark 해제"시 애니메이션
                if isShowingEmptyBookmarkMessage {
                    HStack{
                        Image("BookMark")
                        Text("북마크가 해제되었습니다.")
                            .foregroundColor(.black)
                            .font(.bottles11)
                        
                    }
                    .zIndex(1)
                    .transition(.opacity.animation(.easeIn))
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 30)
                            .foregroundColor(.gray_f7)
                    }
                    .offset(y: 300)
                }
                
                // 예약하기 버튼 클릭 시 예약하기 뷰 present
                ReservationView(bottleData: bottleData, isShowing: $isShowingSheet)
                    //.environmentObject(path)
            }
        }
        // MARK: - 바틀샵 이름
        .toolbar(content: {
            // 네비게이션 장바구니 아이콘
            ToolbarItem(placement: .principal) {
                HStack {
                    Image("Maptabfill")
                        .resizable()
                        .frame(width: 11, height: 16)
                    Text(bottleData.shopName)
                        .font(.bottles18)
                        .fontWeight(.medium)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: {
                    CartView()
                }) {
                    Image("cart")
                        .resizable()
                        .frame(width: 19, height: 18)
                }
            }
        })
        // TabView hidden
        .toolbar(.hidden, for: .tabBar)
        .edgesIgnoringSafeArea([.bottom])
    }
}

class Path: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}

//struct BottleView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView()
//    }
//}
