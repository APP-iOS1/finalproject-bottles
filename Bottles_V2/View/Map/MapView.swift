//
//  MapView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI
import NMapsMap
import CoreLocation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

struct MapView: View {
    
    @EnvironmentObject var shopDataStore: ShopDataStore
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var userDataStore: UserStore
    
    @StateObject var coordinator: Coordinator = Coordinator.shared
    
    @State var coord: (Double, Double) = (37.56668, 126.978419)
    @State var userLocation: (Double, Double) = (37.56668, 126.978419)
    @State var searchBarText: String = ""
    @State var isShowingSheet: Bool = false
    //    @State var showMarkerDetailView: Bool = false
    //    @State var currentShopId: String = "보리마루"
    @State var searchResult: [ShopModel] = []
    @State var tapped: Bool = true
    
    @State var transition: Bool = false
    @State var tapSearchButton: Bool = false
    
    @FocusState var focus: Bool
    
    @Namespace var morphSeamlessly
    @Namespace private var animation
    
    // 북마크한 바틀샵 표시 버튼
    @State var isBookMarkTapped: Bool = false
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("isFirstLaunching") var isFirstLaunching: Bool = true
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                ZStack {
                    VStack {
                        if tapped {
                            ZStack {
                                MapSearchView(searchBarText: $searchBarText, focus: _focus, tapped: $tapped, shopDataStore: _shopDataStore, showMarkerDetailView: $coordinator.showMarkerDetailView, searchResult: $searchResult, currentShopId: $coordinator.currentShopId, tapSearchButton: $tapSearchButton, coord: $coordinator.coord)
                                    .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                                    .frame(maxWidth: 290, maxHeight: 35)
                                    .cornerRadius(10)
                                    .offset(x: -20, y: 0)
                                HStack {
                                    MapSearchBar()
                                        .onTapGesture(count: 1, perform: {
                                            withAnimation (
                                                Animation.easeInOut(duration: 0.5)
                                            ) {
                                                tapped.toggle()
                                            }
                                            // 화면이 전환된 후에 키보드가 올라오도록 딜레이 줬음
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                                focus = true
                                            }
                                        })
                                    NavigationLink {
                                        CartView()
                                    } label: {
                                        Image("cart")
                                            .foregroundColor(.accentColor)
                                            .bold()
                                            .padding(10)
                                            .frame(width: 40)
                                            .background{
                                                Color.white
                                            }
                                            .cornerRadius(10)
                                    }
                                }
                                .padding(.top, 5)
                                .padding(.bottom, 10)
                            }
                        } else {
                            MapSearchView(searchBarText: $searchBarText, focus: _focus, tapped: $tapped, showMarkerDetailView: $coordinator.showMarkerDetailView, searchResult: $searchResult, currentShopId: $coordinator.currentShopId, tapSearchButton: $tapSearchButton, coord: $coordinator.coord)
                                .scaleEffect(tapped ? 0 : 1.2, anchor: .top)
                                .offset(x: tapped ? -22 : 0, y: tapped ? 0 : 0)
                                .opacity(1)
                                .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                        }
                        
                        if tapSearchButton {
                            HStack{
                                Image("xmark")
                                Text("저장한 바틀샵이 없습니다.")
                                    .shakeEffect(trigger: tapSearchButton)
                                    .foregroundColor(.black)
                                    .font(.bottles11)
                            }
                            .zIndex(2)
                            
                            .transition(.opacity.animation(.easeIn))
                            
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 30)
                                    .foregroundColor(.gray_f7)
                            }
                        }
                        Spacer()
                    }
                    // 2로 하면 둘러보기 시트를 올렸을때 검색바가 위로 보여지고, 4로 하면 키보드 올라올때 시트가 올라오는게 보여서 이렇게 수정
                    .zIndex(tapped ? 2 : 4)
                    
                    /// 네이버 지도 뷰
                    NaverMap(currentShopId: $coordinator.currentShopId, showMarkerDetailView: $coordinator.showMarkerDetailView, isBookMarkTapped: $coordinator.isBookMarkTapped)
                        .ignoresSafeArea(.all, edges: .top)
                    
                    /// 북마크 & 현재 위치 버튼
                    HStack {
                        Spacer()
                        
                        SideButtonCell(tapSearchButton: $tapSearchButton, userLocation: $coordinator.userLocation, isBookMarkTapped: $coordinator.isBookMarkTapped)
                    }
                    
                    /// 둘러보기 뷰
                    BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                        NearBySheetView(
                            isOpen: $isShowingSheet,
                            showMarkerDetailView: $coordinator.showMarkerDetailView,
                            currentShopId: $coordinator.currentShopId
                        )
                    }
                    .ignoresSafeArea(.all, edges: .top)
                    .zIndex(2)
                    
                    MarkerDetailSheet(isOpen: $coordinator.showMarkerDetailView, maxHeight: 200) {
                        NavigationLink{
                            BottleShopView(bottleShop: shopDataStore.shopData.filter { $0.id == coordinator.currentShopId }[0])
                            
                        } label: {
                            MarkerDetailView(
                                shopData: shopDataStore.shopData.filter { $0.id == coordinator.currentShopId }[0],
                                showMarkerDetailView: $coordinator.showMarkerDetailView,
                                currentShopId: $coordinator.currentShopId
                            )
                        }
                    }
                    .zIndex(3)
                }
            }
            .sheet(isPresented: $isFirstLaunching) {
                OnboardingView(isFirstLaunching: $isFirstLaunching)
                        }
            
            .onAppear {
                Coordinator.shared.checkIfLocationServicesIsEnabled()
                Coordinator.shared.shopDataStore.shopData = shopDataStore.shopData
                Coordinator.shared.userDataStore.user = userDataStore.user
                //                Coordinator.shared.fetchUserLocation()
                coordinator.makeMarkers()
            }
        }
    }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

