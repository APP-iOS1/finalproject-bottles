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

struct NaverMap: UIViewRepresentable {
    
    @EnvironmentObject var userDataStore: UserStore
    @EnvironmentObject var shopDataStore : ShopDataStore
    
    @Binding var currentShopId: String
    @Binding var showMarkerDetailView: Bool
    //    @Binding var coord: (Double, Double)
    //    @Binding var userLocation: (Double, Double)
    @Binding var isBookMarkTapped: Bool
    
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator.shared
    }
    
    //        init(coord: Binding<(Double, Double)>, showMarkerDetailView: Binding<Bool>, currentShopId: Binding<String>, userLocation: Binding<(Double, Double)>, isBookMarkTapped: Binding<Bool>
    //        ) {
    //            self._coord = coord
    //            self._showMarkerDetailView = showMarkerDetailView
    //            self._currentShopId = currentShopId
    //            self._userLocation = userLocation
    //            self._isBookMarkTapped = isBookMarkTapped
    //        }
    //
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        //        let coord = NMGLatLng(lat: Coordinator.shared.coord.0, lng: Coordinator.shared.coord.1)
        //        let cameraUpdate = NMFCameraUpdate(scrollTo: coord)
        //        cameraUpdate.animation = .fly
        //        cameraUpdate.animationDuration = 1
        //        uiView.mapView.moveCamera(cameraUpdate)
    }
}

final class Coordinator: NSObject, ObservableObject,NMFMapViewCameraDelegate, NMFMapViewTouchDelegate, CLLocationManagerDelegate {
    static let shared = Coordinator()
    
    let view = NMFNaverMapView(frame: .zero)
    
    var userDataStore: UserStore = UserStore()
    var shopDataStore: ShopDataStore = ShopDataStore()
    
    var markers: [NMFMarker] = []
    var bookMarkedMarkers: [NMFMarker] = []
    var locationManager: CLLocationManager?
    
    @Published var currentShopId: String = "보리마루"
    @Published var isBookMarkTapped: Bool = false
    @Published var showMarkerDetailView: Bool = false
    @Published var coord: (Double, Double) = (0.0, 0.0)
    @Published var userLocation: (Double, Double) = (0.0, 0.0)
    
    override init() {
        super.init()
        
        view.showZoomControls = false
        view.mapView.positionMode = .direction
        view.mapView.isNightModeEnabled = true
        // MARK: - 줌 레벨 제한
        view.mapView.zoomLevel = 15 // 기본 카메라 줌 레벨
        view.mapView.minZoomLevel = 10 // 최소 줌 레벨
        view.mapView.maxZoomLevel = 17 // 최대 줌 레벨
        // MARK: - 현 위치 추적 버튼
        view.showLocationButton = false
        view.showCompass = false
        view.showZoomControls = false
        
        // MARK: - NMFMapViewCameraDelegate를 상속 받은 Coordinator 클래스 넘겨주기
        view.mapView.addCameraDelegate(delegate: self)
        
        // MARK: - 지도 터치 시 발생하는 touchDelegate
        view.mapView.touchDelegate = self
    }
    
    deinit {
        print("Coordinator deinit!")
    }
    
    func mapView(_ mapView: NMFMapView, cameraWillChangeByReason reason: Int, animated: Bool) {
        // print("카메라 변경 - reason: \(reason)")
    }
    
    func mapView(_ mapView: NMFMapView, cameraIsChangingByReason reason: Int) {
        // MARK: - 카메라 변경 Reason 번호 별 차이
        /// 0 : 개발자의 코드로 화면이 움직였을 때
        /// -1 : 사용자의 제스처로 화면이 움직였을 때
        /// -2 : 버튼 선택으로 카메라가 움직였을 때
        /// -3 : 네이버 지도가 제공하는 위치 트래킹 기능으로 카메라가 움직였을 때
        // print("카메라 변경 - reason: \(reason)")
        
        // MARK: - 카메라 위치 변경 시 위도/경도 값 받아오기
        // let cameraPosition = mapView.cameraPosition
        // print("카메라 위치 변경 : \(cameraPosition.target.lat)", "\(cameraPosition.target.lng)")
    }
    
    func checkIfLocationServicesIsEnabled() {
        DispatchQueue.global().async {
            if CLLocationManager.locationServicesEnabled() {
                DispatchQueue.main.async {
                    self.locationManager = CLLocationManager()
                    self.locationManager!.delegate = self
                    self.checkLocationAuthorization()
                }
            } else {
                print("Show an alert letting them know this is off and to go turn i on.")
            }
        }
    }
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
        case .denied:
            print("You have denied this app location permission. Go into setting to change it.")
        case .authorizedAlways, .authorizedWhenInUse:
            print("Success")
            coord = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-coord: \(coord)")
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("LocationManager-userLocation: \(userLocation)")
            fetchUserLocation()
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func getNaverMapView() -> NMFNaverMapView {
        view
    }
    
    func makeMarkers() {
        for shopMarker in shopDataStore.shopData {
            let marker = NMFMarker()
            
            marker.position = NMGLatLng(lat: shopMarker.location.latitude, lng: shopMarker.location.longitude)
            marker.captionRequestedWidth = 100 // 마커 캡션 너비 지정
            marker.captionText = shopMarker.shopName
            marker.captionMinZoom = 10
            marker.captionMaxZoom = 17
            marker.iconImage = NMFOverlayImage(name: shopMarker.isRegister ? "MapMarker.fill" : "MapMarker")
            marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
            marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
            
            markers.append(marker)
        }
        
        for marker in markers {
            marker.mapView = view.mapView
        }
        markerTapped()
    }
    
    func makeBookMarkedMarkers() {
        for bookMarkedShop in filterUserShopData() {
            let marker = NMFMarker()
            marker.position = NMGLatLng(lat: bookMarkedShop.location.latitude, lng: bookMarkedShop.location.longitude)
            marker.captionRequestedWidth = 100 // 마커 캡션 너비 지정
            marker.captionText = bookMarkedShop.shopName
            marker.captionMinZoom = 10
            marker.captionMaxZoom = 17
            marker.iconImage = NMFOverlayImage(name: bookMarkedShop.isRegister ? "MapMarker.fill" : "MapMarker")
            marker.width = CGFloat(NMF_MARKER_SIZE_AUTO)
            marker.height = CGFloat(NMF_MARKER_SIZE_AUTO)
            
            bookMarkedMarkers.append(marker)
        }
        
        for marker in bookMarkedMarkers {
            marker.mapView = view.mapView
        }
        markerTapped()
    }
    
    func removeMarkers() {
        while !markers.isEmpty {
            let removeMarker = markers.removeFirst()
            removeMarker.mapView = nil
        }
        while !bookMarkedMarkers.isEmpty {
            let removeMarker = bookMarkedMarkers.removeFirst()
            removeMarker.mapView = nil
        }
    }
    
    func fetchUserLocation() {
        if let locationManager = locationManager {
            let lat = locationManager.location?.coordinate.latitude
            let lng = locationManager.location?.coordinate.longitude
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0))
            cameraUpdate.animation = .fly
            cameraUpdate.animationDuration = 1
            
            // MARK: - 현재 위치 좌표 overlay 마커 표시
            let locationOverlay = view.mapView.locationOverlay
            locationOverlay.location = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
            locationOverlay.hidden = false
            
            // MARK: - 내 주변 5km 반경 overlay 표시
            let circle = NMFCircleOverlay()
            circle.center = NMGLatLng(lat: lat ?? 0.0, lng: lng ?? 0.0)
            circle.radius = 5000
            circle.mapView = nil
            
            view.mapView.moveCamera(cameraUpdate)
        }
    }
    
    // MARK: - Mark 터치 시 이벤트 발생
    func markerTapped() {
        if !isBookMarkTapped {
            print(markers)
            for marker in markers {
                marker.touchHandler = { [self] (overlay) -> Bool in
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: marker.position.lat, lng: marker.position.lng))
                    cameraUpdate.animation = .fly
                    cameraUpdate.animationDuration = 1
                    self.view.mapView.moveCamera(cameraUpdate)
                    self.showMarkerDetailView = true
                    self.currentShopId = marker.captionText
                    print("showMarkerDetailView : \(self.showMarkerDetailView)")
                    print(currentShopId)
                    
                    return true
                }
                marker.mapView = view.mapView
            }
        } else {
            print(bookMarkedMarkers)
            for marker in bookMarkedMarkers {
                marker.touchHandler = { [self] (overlay) -> Bool in
                    let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: marker.position.lat, lng: marker.position.lng))
                    cameraUpdate.animation = .fly
                    cameraUpdate.animationDuration = 1
                    self.view.mapView.moveCamera(cameraUpdate)
                    
                    self.showMarkerDetailView = true
                    self.currentShopId = marker.captionText
                    print("showMarkerDetailView : \(self.showMarkerDetailView)")
                    print(currentShopId)
                    
                    return true
                }
                marker.mapView = view.mapView
            }
        }
    }
    
    // MARK: - 카메라 이동
    func moveCameraPosition() {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: coord.0, lng: coord.1))
        cameraUpdate.animation = .fly
        cameraUpdate.animationDuration = 1
        Coordinator.shared.view.mapView.moveCamera(cameraUpdate)
    }
    // MARK: - 지도 터치에 이용되는 Delegate
    /// 지도 터치 시 MarkerDetailView 창 닫기
    func mapView(_ mapView: NMFMapView, didTapMap latlng: NMGLatLng, point: CGPoint) {
        print("Map Tapped")
        showMarkerDetailView = false
    }
    
    // MARK: - 북마크 유무 확인
    func filterUserShopData() -> [ShopModel] {
        var bookMarkedBottleShops: [ShopModel] = []
        
        for bookMarkedBottleShop in userDataStore.user.followShopList {
            let filterData = shopDataStore.shopData.filter {$0.id == bookMarkedBottleShop}[0]
            bookMarkedBottleShops.append(filterData)
        }
        return bookMarkedBottleShops
    }
}
