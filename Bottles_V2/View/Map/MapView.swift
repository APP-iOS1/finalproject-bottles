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
    
    @State var coord: (Double, Double) = (126.9784147, 37.5666805)
    @State var locationManager: CLLocationManager!
    @State var mapSearchBarText: String = ""
    @State var isShowingSheet: Bool = true
    
    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
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
                
                UIMapView(coord)
                    .edgesIgnoringSafeArea(.top)
            }
//            .sheet(isPresented: $isShowingSheet) {
//                NearBySheetView()
//                    .presentationDragIndicator(.visible)
//                    .presentationDetents(Set(heights))
//
//            }
        }
    }
}

struct UIMapView: UIViewRepresentable {
    
    let view = NMFNaverMapView()
    var locationManager: CLLocationManager = CLLocationManager()
    var coord: (Double, Double)
    
    init(_ coord: (Double, Double)) {
        self.coord = coord
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        view.showZoomControls = true
        
        // MARK: - 현 위치 추적
        view.showLocationButton = true
        
        view.mapView.positionMode = .normal
        view.mapView.zoomLevel = 17
        
        // MARK: - 줌 레벨 제한
        view.mapView.minZoomLevel = 13
        
        view.mapView.addCameraDelegate(delegate: context.coordinator)
    
        // MARK: - Delegate Coordinator 뷰에 뿌려주기
        locationManager.delegate = context.coordinator
        
        return view
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        let coord = NMGLatLng(lat: coord.1, lng: coord.0)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
        
        // MARK: - 마커 생성
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
        marker.mapView = uiView.mapView
        marker.touchHandler = { (overlay) -> Bool in
            print("마커 터치")
            return true
          }
        // MARK: - 마커 이미지 변경
        marker.iconImage = NMFOverlayImage(name: "MapMarker")
        marker.width = 40
        marker.height = 50
    }
    
    class Coordinator: NSObject, CLLocationManagerDelegate, NMFMapViewCameraDelegate {
        var locationManager: CLLocationManager = CLLocationManager()
        
        override init() {
            super.init()
            
            locationManager.delegate = self
        }
        
        func getLocationUsagePermission() {
            self.locationManager.requestWhenInUseAuthorization()
        }

        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            switch status {
            case .authorizedAlways, .authorizedWhenInUse:
                print("GPS 권한 설정됨")
            case .restricted, .notDetermined:
                print("GPS 권한 설정되지 않음")
                getLocationUsagePermission()
            case .denied:
                print("GPS 권한 요청 거부됨")
                getLocationUsagePermission()
            default:
                print("GPS: Default")
            }
        }
        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            print("카메라 변경 - reason: \(reason)")
        }
        
        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            print("카메라 변경 - reason: \(reason)")
        }
        
//        func addMarker(_ mapView: NMFNaverMapView) {
//          // 마커 생성하기
//          let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: 37.5670135, lng: 126.9783740)
////            marker.mapView = view.mapView
////            marker.iconImage = NMFOverlayImage(name: "orem")
////            marker.iconTintColor = UIColor.red
////            marker.width = 25
////            marker.height = 40
//          // 마커 userInfo에 placeId 저장하기
//
//            marker.mapView = mapView.mapView
//
//          // 터치 이벤트 설정
//          marker.touchHandler = { (overlay) -> Bool in
//            print("마커 터치")
////            print(overlay.userInfo["placeId"] ?? "placeId없음")
////            viewModel.place = place
////            viewModel.placeId = overlay.userInfo["placeId"] as! String
////            viewModel.isBottomPageUp = true
//            return true
//          }
//        }
    }
    
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

