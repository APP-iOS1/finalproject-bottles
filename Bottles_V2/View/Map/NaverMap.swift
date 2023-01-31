//
//  NaverMap.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import SwiftUI
import NMapsMap

// MARK: - 마커 더미 데이터 생성
//struct Marker: Identifiable {
//    let id: String
//    let latitude: Double
//    let longitude: Double
//}
//
//class MarkerStore: ObservableObject {
//    var markers: [Marker] = []
//
//    init() {
//        markers = [
//            Marker(id: UUID().uuidString, latitude: 37.5670135, longitude: 126.9783740),
//            Marker(id: UUID().uuidString, latitude: 37.6670135, longitude: 126.9883740),
//            Marker(id: UUID().uuidString, latitude: 37.7670135, longitude: 126.9983740),
//            Marker(id: UUID().uuidString, latitude: 37.3670135, longitude: 126.9683740),
//            Marker(id: UUID().uuidString, latitude: 37.4670135, longitude: 126.9583740)
//        ]
//    }
//}

struct NaverMap: UIViewRepresentable {
    var coord: (Double, Double)
//    var markers: [Marker]
    @Binding var showMarkerDetailView: Bool
    func makeCoordinator() -> Coordinator {
        Coordinator(coord)
    }
    
    init(_ coord: (Double, Double), _ showMarkerDetailView: Binding<Bool>
    ) {
        self.coord = coord
        self._showMarkerDetailView = showMarkerDetailView
    }
    
    class Coordinator: NSObject, NMFMapViewCameraDelegate {
        var coord: (Double, Double)
        init(_ coord: (Double, Double)) {
            self.coord = coord
        }
        
        
        func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
            print("카메라 변경 - reason: \(reason)")
        }
        
        func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
            print("카메라 변경 - reason: \(reason)")
        }
    }
    
    func makeUIView(context: Context) -> some NMFNaverMapView {
        let view = NMFNaverMapView()
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        
        // MARK: - 줌 레벨 제한
        view.mapView.zoomLevel = 17
        view.mapView.minZoomLevel = 15
        
        let locationOverlay = view.mapView.locationOverlay
        
        // MARK: - 현 위치 추적 버튼
        view.showLocationButton = true
        
        view.showCompass = false
        view.showZoomControls = true
        let cameraPosition = view.mapView.cameraPosition
        
        // MARK: - 마커 생성
//        for shopMarker in markers {
            let marker = NMFMarker()
//            marker.position = NMGLatLng(lat: shopMarker.latitude, lng: shopMarker.longitude)
        // 임시 마커(서울시청)
            marker.position = NMGLatLng(lat: 37.56668, lng: 126.978415)
            marker.captionRequestedWidth = 100
            //            marker.captionText = foodCart.name
            marker.captionMinZoom = 12
            marker.captionMaxZoom = 16
            
            // MARK: - 마커 이미지 변경
            marker.iconImage = NMFOverlayImage(name: "MapMarker")
            marker.width = 40
            marker.height = 50
            
            // MARK: - 마커 터치 핸들러
            marker.touchHandler = { (overlay) -> Bool in
                print("marker touched")
                showMarkerDetailView.toggle()
                return true
            }
            
            marker.mapView = view.mapView
//        }
        print("camera position: \(cameraPosition)")
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        let coord = NMGLatLng(lat: coord.0, lng: coord.1)
        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        uiView.mapView.moveCamera(cameraUpdate)
    }
}
