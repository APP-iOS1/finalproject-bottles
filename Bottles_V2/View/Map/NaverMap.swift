//
//  NaverMap.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import SwiftUI
import NMapsMap
import Firebase
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift   //GeoPoint 사용을 위한 프레임워크

struct MapMarkerByShopData {
    var shopID: String
    var shopName: String
    var location: GeoPoint
}

struct NaverMap: UIViewRepresentable {
    @Binding var moveToUserLocation: Bool
    @Binding var showMarkerDetailView: Bool
    @Binding var mappinShopID : ShopModel
    @EnvironmentObject var shopDataStore : ShopDataStore
    @State var shopInfo : [MapMarkerByShopData] = []
    
    @Binding var coord: (Double, Double)
    @Binding var userLocation: (Double, Double)
    //    var markers: [Marker]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(coord, userLocation, $showMarkerDetailView, $moveToUserLocation)
    }
    
    init(_ coord: Binding<(Double, Double)>,
         _ userLocation: Binding<(Double, Double)>,
         _ showMarkerDetailView: Binding<Bool>,
         _ mappinShopID: Binding<ShopModel>,
         _ moveToUserLocation: Binding<Bool>
    ) {
        self._coord = coord
        self._userLocation = userLocation
        self._showMarkerDetailView = showMarkerDetailView
        self._mappinShopID = mappinShopID
        self._moveToUserLocation = moveToUserLocation
        
        //        for shopMarker in shopDataStore.shopData {
        //                let marker = NMFMarker()
        //            marker.position = NMGLatLng(lat: shopMarker.location.latitude, lng: shopMarker.location.longitude)
        //            }
        
    }
    
    // 모든 shopDataStore의 위경도, 샵이름, 샵ID를 배열로 가지는 배열을 생성
    //    func locationAndshopInfo() {
    //
    //        let shopAllData = shopDataStore.shopData
    //
    //        for oneShop in shopAllData {
    //            var data : [MapMarkerByShopData] = []
    //            self.shopInfo.append(
    //                MapMarkerByShopData(shopID: oneShop.id, shopName: oneShop.shopName, location: oneShop.location)
    //            )
    //            print("나왕라ㅏㅏ \(self.shopInfo)")
    //        }
    //    }
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
        @Binding var moveToUserLocation: Bool
        @Binding var showMarkerDetailView: Bool
        var coord: (Double, Double)
        var userLocation: (Double, Double)
        
        init(_ coord: (Double, Double), _ userLocation: (Double, Double), _ showMarkerDetailView: Binding<Bool>, _ moveToUserLocation: Binding<Bool>) {
            self.coord = coord
            self.userLocation = userLocation
            self._showMarkerDetailView = showMarkerDetailView
            self._moveToUserLocation = moveToUserLocation
        }
        
        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            print("카메라 변경 - reason: \(reason)")
        }
        
        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            // MARK: - 카메라 변경 Reason 번호 별 차이
            /// 0 : 개발자의 코드로 화면이 움직였을 때
            /// -1 : 사용자의 제스처로 화면이 움직였을 때
            /// -2 : 버튼 선택으로 카메라가 움직였을 때
            /// -3 : 네이버 지도가 제공하는 위치 트래킹 기능으로 카메라가 움직였을 때
            print("카메라 변경 - reason: \(reason)")
            
            // MARK: - 카메라 위치 변경 시 위도/경도 값 받아오기
            let cameraPosition = mapView.cameraPosition
            print("카메라 위치 변경 : \(cameraPosition.target.lat)", "\(cameraPosition.target.lng)")
        }
        
        // MARK: - 지도 터치에 이용되는 Delegate
        /// 지도 터치 시 MarkerDetailView 창 닫기
        func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
            print("Map Tapped")
            showMarkerDetailView = false
        }
    }
    
    func makeUIView(context: Context) -> some NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        
        // MARK: - 줌 레벨 제한
        view.mapView.zoomLevel = 13 // 기본 카메라 줌 레벨
        view.mapView.minZoomLevel = 10 // 최소 줌 레벨
        
        let locationOverlay = view.mapView.locationOverlay
        
        // MARK: - 현 위치 추적 버튼
        view.showLocationButton = true
        
        view.showCompass = false
        view.showZoomControls = false
        let cameraPosition = view.mapView.cameraPosition
        
        // MARK: - 마커 생성
        
        //        let shopAllData = self.shopDataStore.shopData
        //        var shopInfoList : [MapMarkerByShopData] = []
        //        for oneShop in shopAllData {
        //            shopInfoList.append(
        //                MapMarkerByShopData(shopID: oneShop.id, shopName: oneShop.shopName, location: oneShop.location)
        //            )
        //        }
        print("샵데이터 : \(self.shopDataStore.shopData.count)")
        
        for shopMarker in self.shopDataStore.shopData {
            let marker = NMFMarker()
            //            marker.position = NMGLatLng(lat: shopMarker.latitude, lng: shopMarker.longitude)
            // 임시 마커(서울시청)
            // TODO: 아래 코드 위경도를 바꿔주면 서 for 문 생성
            //
            //            let test = shopMarker.location.latitude
            //            let test2 = shopMarker.location.longitude
            //            print("이게 찐중요 위경도 나와라 얍 : \(test), \(test2)")
            marker.position = NMGLatLng(lat: shopMarker.location.latitude, lng: shopMarker.location.longitude)
            //        marker.position = NMGLatLng(lat: 32.56668, lng: 124.978415)
            marker.captionRequestedWidth = 100
            //            marker.captionText = foodCart.name
            marker.captionMinZoom = 12
            marker.captionMaxZoom = 16
            
            // MARK: - 마커 이미지 변경
            marker.iconImage = NMFOverlayImage(name: "MapMarker.fill")
            marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
            marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
            
            // MARK: - 마커 터치 핸들러
            marker.touchHandler = { (overlay) -> Bool in
                print("marker touched")
                mappinShopID = shopMarker
                showMarkerDetailView = true
                
                // 마커 터치 시 마커 아이콘 크기 변경
                marker.iconImage = NMFOverlayImage(name: showMarkerDetailView ? "MapMarker_tapped" : "MapMarker.fill")
                marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
                marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
                
                // 마커 터치 시 해당 마커 좌표로 카메라 이동
                coord = (marker.position.lat,marker.position.lng)
                
                return true
            }
            
            marker.mapView = view.mapView
            
            // MARK: - NMFMapViewCameraDelegate를 상속 받은 Coordinator 클래스 넘겨주기
            view.mapView.addCameraDelegate(delegate: context.coordinator)
            
            // MARK: - 지도 터치 시 발생하는 touchDelegate
            view.mapView.touchDelegate = context.coordinator
        }
        print("camera position: \(cameraPosition)")
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        if moveToUserLocation {
            let userLocation = NMGLatLng(lat: userLocation.0, lng: userLocation.1)
            let cameraUpdate = NMFCameraUpdate(scrollTo: userLocation)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            uiView.mapView.moveCamera(cameraUpdate)
            
            moveToUserLocation = false
            
        } else {
            let coord = NMGLatLng(lat: coord.0, lng: coord.1)
            let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            uiView.mapView.moveCamera(cameraUpdate)
        }
    }
}


