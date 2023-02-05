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
    
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    @State var coord: (Double, Double) = (37.56668, 126.978419)
    @State var userLocation: (Double, Double) = (37.56668, 126.978419)
    @State var mapSearchBarText: String = ""
    @State var isShowingSheet: Bool = false
    @State var showMarkerDetailView: Bool = false
    @State var moveToUserLocation: Bool = true
    @State var mappinShopID : ShopModel = ShopModel(id: "0", shopName: "0", shopOpenCloseTime: "0", shopAddress: "0", shopPhoneNumber: "0", shopIntroduction: "0", shopSNS: "0", followerUserList: ["0"], isRegister: true, location: GeoPoint(latitude: 0, longitude: 0), reservedList: ["0"], shopTitleImage: "0", shopImages: ["0"], shopCurationTitle: "0", shopCurationBody: "0", shopCurationImage: "0", shopCurationBottleID: ["0"], bottleCollections: ["0"], noticeCollection: ["0"], reservationCollection: ["0"])
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        
                        // 검색 바
                        MapViewSearchBar(mapSearchBarText: $mapSearchBarText)
                        
                        NavigationLink {
                            CartView()
                        } label: {
                            Image(systemName: "cart")
                                .foregroundColor(.accentColor)
                                .bold()
                                .padding(10)
                                .frame(width: 40)
                            
                                .background{
                                    Color.white
                                }
                                .cornerRadius(10)
                                .shadow(color: Color("BottleShopDetailBGShadowColor"), radius: 3, x: 0, y: 4)
                        }
                    }
                    Spacer()
                }
                .zIndex(1)
                
                /// 네이버 지도 뷰
                NaverMap($mapViewModel.coord, $mapViewModel.userLocation, $showMarkerDetailView, $mappinShopID, $moveToUserLocation)
                    .ignoresSafeArea(.all, edges: .top)
                /// 북마크 & 현재 위치 버튼
                HStack {
                    Spacer()
                    SideButtonCell(mapViewModel: mapViewModel, userLocation: $userLocation, moveToUserLocation: $moveToUserLocation)
                }
                /// 둘러보기 뷰
                
                BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                    NearBySheetView()
                }
                .ignoresSafeArea(.all, edges: .top)
                .zIndex(2)
                
                MarkerDetailSheet(isOpen: $showMarkerDetailView, maxHeight: 200) {
                    MarkerDetailView(mappinShop: $mappinShopID)
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



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

