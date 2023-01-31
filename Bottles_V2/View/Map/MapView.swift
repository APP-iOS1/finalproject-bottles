//
//  MapView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct MapView: View {
    
    @StateObject var mapViewModel: MapViewModel = MapViewModel()
    @State var mapSearchBarText: String = ""
    @State var isShowingSheet: Bool = false
    @State var showMarkerDetailView: Bool = false
    
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
                NaverMap((mapViewModel.coord.0, mapViewModel.coord.1), $showMarkerDetailView)
                    .ignoresSafeArea(.all, edges: .top)
                
                /// 둘러보기 뷰
                BottomSheetView(isOpen: $isShowingSheet, maxHeight: 200) {
                    NearBySheetView()
                }
                .ignoresSafeArea(.all, edges: .top)
                .zIndex(2)
                
                // MARK: - 현재 위치 이동 버튼(커스텀)
//                Button {
//                    //
//                } label: {
//                    Text("현재 위치로 이동")
//                }
            }
            .sheet(isPresented: $showMarkerDetailView, content: {
                MarkerDetailView()
                    .presentationDetents([.height(250)])
                    .presentationDragIndicator(.visible)
            })
            
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
            }
            
        }
    }
}



struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

