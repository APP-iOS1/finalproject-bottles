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
    @State var tapSearchButton: Bool = false
    
    @Namespace private var animation
    
    var body: some View {
        NavigationStack {
            ZStack {
                
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
                    Spacer()
                }
                .zIndex(1)
                
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
                
                // MARK: - 현재 위치 이동 버튼(커스텀)
                //                Button {
                //                    //
                //                } label: {
                //                    Text("현재 위치로 이동")
                //                }
            }
            //            .sheet(isPresented: $showMarkerDetailView, content: {
            //                MarkerDetailView()
            //                    .presentationDetents([.height(250)])
            //                    .presentationDragIndicator(.visible)
            //            })
            
            // TODO: - 보라색 에러 async/await로 해결해보기
            //            .task {
            //                if await mapViewModel.locationServicesEnabled() {
            //                    // Do something
            //                    let locationManager = CLLocationManager()
            //                    locationManager.delegate = mapViewModel
            //                    mapViewModel.checkLocationAuthorization()
            //                }
            //            }
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

