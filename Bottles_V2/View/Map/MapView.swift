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
    
    @State var coord: (Double, Double) = (37.56668, 126.978419)
    @State var userLocation: (Double, Double) = (37.56668, 126.978419)
    @State var searchBarText: String = ""
    @State var isShowingSheet: Bool = false
    @State var showMarkerDetailView: Bool = false
    @State var currentShopId: String = "보리마루"
    @State var searchResult: [ShopModel] = []
    @State var tapped: Bool = true
    
    @State var transition: Bool = false
    @State var tapSearchButton: Bool = false
    
    @FocusState var focus: Bool
    
    @Namespace var morphSeamlessly
    @Namespace private var animation
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                ZStack {
                    VStack {
                        if tapped {
                            ZStack {
                                MapSearchView(searchBarText: $searchBarText, focus: _focus, tapped: $tapped, mapViewModel: _mapViewModel, shopDataStore: _shopDataStore, showMarkerDetailView: $showMarkerDetailView, searchResult: $searchResult, currentShopId: $currentShopId, tapSearchButton: $tapSearchButton)
                                    .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                                    .frame(maxWidth: 293, maxHeight: 35)
                                    .offset(x: -22, y: -300)
                                //                                    .onTapGesture(count: 1, perform: {
                                //                                        withAnimation (
                                //                                            Animation.easeInOut(duration: 0.3)
                                //                                        ) {
                                //                                            tapped.toggle()
                                //                                        }
                                //                                    })
                                HStack {
                                    MapSearchBar()
                                    //                                        .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                                        .onTapGesture(count: 1, perform: {
                                            withAnimation (
                                                Animation.easeInOut(duration: 0.5)
//                                                Animation.linear(duration: 0.5)
//                                                Animation.easeIn(duration: 0.5)
                                            ) {
                                                tapped.toggle()
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
                                .padding(.bottom, 10)
                            }
                            
                            
                            //                            .zIndex(4)
                        } else {
                            MapSearchView(searchBarText: $searchBarText, tapped: $tapped, showMarkerDetailView: $showMarkerDetailView, searchResult: $searchResult, currentShopId: $currentShopId, tapSearchButton: $tapSearchButton)
                            //                            MapSearchView(tapped: $tapped)
                                .scaleEffect(tapped ? 0 : 1.2, anchor: .top)
                                .offset(x: tapped ? -22 : 0, y: tapped ? -333 : 0)
                                .opacity(1)
                                .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                            //                                .ignoresSafeArea()
                        }
                        
                        if tapSearchButton {
                            HStack{
                                Image("xmark")
                                Text("검색 결과가 없습니다.")
                                    .shakeEffect(trigger: tapSearchButton)
                                    .foregroundColor(.black)
                                    .font(.bottles11)
                            }
                            .zIndex(2)
                            
                            //                        .transition(.opacity.animation(.easeIn))
                            
                            .background{
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(width: 300, height: 30)
                                    .foregroundColor(.gray_f7)
                            }
                        }
                        Spacer()
                    }
                    .zIndex(3)
                    
                    /// 네이버 지도 뷰
                    NaverMap($mapViewModel.coord, $showMarkerDetailView, $currentShopId, $mapViewModel.userLocation)
                        .ignoresSafeArea(.all, edges: .top)
                    
                    /// 북마크 & 현재 위치 버튼
                    HStack {
                        Spacer()
                        
                        SideButtonCell(mapViewModel: mapViewModel, userLocation: $mapViewModel.userLocation)
                    }
                    
                    /// 둘러보기 뷰
                    BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                        NearBySheetView(
                            mapViewModel: mapViewModel,
                            isOpen: $isShowingSheet,
                            showMarkerDetailView: $showMarkerDetailView,
                            currentShopId: $currentShopId
                        )
                    }
                    .ignoresSafeArea(.all, edges: .top)
                    .zIndex(2)
                    
                    MarkerDetailSheet(isOpen: $showMarkerDetailView, maxHeight: 200) {
                        NavigationLink{
                            BottleShopView(bottleShop: shopDataStore.shopData.filter { $0.id == currentShopId }[0])
                            
                        } label: {
                            MarkerDetailView(
                                shopData: shopDataStore.shopData.filter { $0.id == currentShopId }[0],
                                showMarkerDetailView: $showMarkerDetailView,
                                currentShopId: $currentShopId
                            )
                        }
                    }
                    .zIndex(3)
                    
                    // TODO: - 보라색 에러 async/await로 해결해보기
                    //            .task {
                    //                if await mapViewModel.locationServicesEnabled() {
                    //                    // Do something
                    //                    let locationManager = CLLocationManager()
                    //                    locationManager.delegate = mapViewModel
                    //                    mapViewModel.checkLocationAuthorization()
                    //                }
                    //            }
                    //                }
                    
                }
            }
            .onAppear {
                mapViewModel.checkIfLocationServicesIsEnabled()
                coord = mapViewModel.coord
            }
        }
    }
}



//struct MapView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapView()
//    }
//}

