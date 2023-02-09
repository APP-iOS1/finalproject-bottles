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
    @State var mapSearchBarText: String = ""
    @State var isShowingSheet: Bool = false
    @State var showMarkerDetailView: Bool = false
    @State var currentShopId: String = "보리마루"
    @State var searchResult: [ShopModel] = []
    @State var tapped: Bool = true
    
    @State var transition: Bool = false
    @State var tapSearchButton: Bool = false
    
    @Namespace var morphSeamlessly
    @Namespace private var animation
    
    var body: some View {
        
        NavigationStack {
            ZStack {
// ZStack 추가    
                VStack {
                    HStack {
                        // 검색 바
                        MapViewSearchBar(showMarkerDetailView: $showMarkerDetailView, mapSearchBarText: $mapSearchBarText, searchResult: $searchResult, currentShopId: $currentShopId, tapSearchButton: $tapSearchButton)
                        
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
//                                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
                        }
                    }
                    .padding(.bottom, 10)
                    
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
                    .ignoresSafeArea(.all, edges: .top)
                    .zIndex(2)
                    
                    SideButtonCell(mapViewModel: mapViewModel, userLocation: $mapViewModel.userLocation)
                }
                
                /// 둘러보기 뷰
                BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                    NearBySheetView(
                        mapViewModel: mapViewModel,
                        isOpen: $isShowingSheet,
                        showMarkerDetailView: $showMarkerDetailView,
                        currentShopId: $currentShopId
                        //                        currentShopIndex: $currentShopIndex,
                        //                        shopModel: $shopModel
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
                
                
                if tapped {
                    ZStack {
                        MapSearchView(tapped: $tapped)
                            .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                            .offset(x: -22, y: -333)
                        
                            .frame(maxWidth: 293, maxHeight: 35)
                        
                            .onTapGesture(count: 1, perform: {
                                withAnimation (
                                    Animation.easeInOut(duration: 0.3)
                                ) {
                                    tapped.toggle()
                                }
                            })
                        Text("바틀샵/상품을 입력해주세요")
                            .offset(x: -68, y: -333)
                            .font(.callout)
                            .foregroundColor(Color(UIColor.systemGray3))
                    }
                     
                } else {
                    MapSearchView(tapped: $tapped)
                        .scaleEffect(tapped ? 0 : 1.2, anchor: .center)
                        .offset(x: tapped ? -22 : 0, y: tapped ? -333 : 0)
                        .opacity(1)
                        .matchedGeometryEffect(id: "scale", in: morphSeamlessly)
                        .ignoresSafeArea()
                    
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

