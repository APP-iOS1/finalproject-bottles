//
//  MapViewModel.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/20.
//

import SwiftUI
import CoreLocation

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    var locationManager: CLLocationManager?
    @Published var coord = (0.0, 0.0)
    @Published var userLocation = (0.0, 0.0)
    // 마커 배열 생성
    //    @Published var marker: [Marker] = []
    
    func checkIfLocationServicesIsEnabled() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            checkLocationAuthorization()
        } else {
            print("Show an alert letting them know this is off and to go turn i on.")
        }
        
    }
    
    // TODO: - CoreLocation 보라색 에러 해결하기
    /*
     Task { [weak self] in
     
     if await self?.locationServicesEnabled() {
     // Do something
     }
     }
     */
    
    func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted likely due to parental controls.")
            coord = (37.56668,126.978415)
        case .denied:
            print("You have denied this app location permission. Go into setting to change it.")
            coord = (37.56668,126.978415)
        case .authorizedAlways, .authorizedWhenInUse:
            coord = (Double(locationManager.location?.coordinate.latitude ?? 37.56668), Double(locationManager.location?.coordinate.longitude ?? 126.978415))
            userLocation = (Double(locationManager.location?.coordinate.latitude ?? 0.0), Double(locationManager.location?.coordinate.longitude ?? 0.0))
            print("GPS 권한 설정 완료")
            print("coord : \(coord)")
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
    func locationServicesEnabled() async -> Bool {
        CLLocationManager.locationServicesEnabled()
    }
}
