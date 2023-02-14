//
//  MapSearchView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/08.
//

import SwiftUI
import CoreLocation

struct MapSearchView: View {
    
    // 뷰 이동 시 해당 텍스트필드에 키보드 포커스
    enum FocusField: Hashable {
        case field
    }
    
    @Binding var searchBarText: String // 텍스트필드에 입력되는 텍스트
    @State var doneTextFieldEdit: Bool = false
    @FocusState var focus: Bool  // 포커스된 텍스트필드
    @Binding var tapped: Bool // MapView에서의 텍스트 필드의 tap여부를 바인딩으로 넘김
//    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var shopDataStore: ShopDataStore
    @Binding var showMarkerDetailView: Bool
    @Binding var searchResult: [ShopModel]
    @Binding var currentShopId: String
    @Binding var tapSearchButton: Bool
    @Binding var coord: (Double, Double)
    @StateObject var coordinator: Coordinator = Coordinator.shared

    // MARK: - 검색 로직 및 거리 순 오름차순 정렬 함수
    func getSearchResult(searchText: String) -> [ShopModel] {
        let filteredData = self.shopDataStore.shopData
        if !searchText.isEmpty {
            return filteredData.filter {
                $0.shopName.contains(searchText)
            }.sorted(by: {$0.shopName < $1.shopName }).sorted(by: {distance($0.location.latitude, $0.location.longitude) < distance($1.location.latitude, $1.location.longitude)})
        }
        return filteredData
    }
    
    // MARK: - 현재 위치 좌표 거리 계산 함수
    func distance(_ lat: Double, _ log: Double) -> CLLocationDistance {
        let from = CLLocation(latitude: lat, longitude: log)
        let to = CLLocation(latitude: coordinator.userLocation.0, longitude: coordinator.userLocation.1)
        //        print("\(from.distance(from: to))")
        return from.distance(from: to)
    }
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                Color.white
                if !tapped {
                    VStack {
                        // MARK: - SearchBar
                        HStack {
                            //  Navigation Bar 의 Back Button을 유사하게 구현
                            Image(systemName: "chevron.backward")
                                .font(.title2)
                                .frame(width: 20, height: 20)
                                .onTapGesture(count: 1, perform: {
                                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                    withAnimation (
                                        Animation.easeInOut(duration: 0.5)
                                    ) {
                                        tapped.toggle()
                                    }
                                })
                            MapViewSearchBar(showMarkerDetailView: $showMarkerDetailView, searchBarText: $searchBarText, searchResult: $searchResult, currentShopId: $currentShopId, tapSearchButton: $tapSearchButton, focus: _focus)
                        }
                        .offset(y: 50)
                        
                        // MARK: - 검색 리스트
                        List {
                            if getSearchResult(searchText: searchBarText).isEmpty {
                                HStack(alignment: .center) {
                                    Image("xmark")
                                    Text("검색 결과가 없습니다.")
                                        .foregroundColor(.black)
                                        .font(.bottles11)
                                }
                            } else {
                                ForEach (getSearchResult(searchText: searchBarText), id: \.self) { item in
                                    
                                    let distance = distance(item.location.latitude, item.location.longitude)
                                    
                                    // 검색어와 겹치는 단어가 있는지 없는지 확인
                                    if item.shopName.replacingOccurrences(of: " ", with: "").contains(searchBarText.replacingOccurrences(of: " ", with: "")) {
                                        Button {
                                            doneTextFieldEdit = true
                                            
                                            // 사용자가 리스트에서 찾고자하는 단어가 있어 터치 시, 해당 단어를 검색창의 텍스트로 전환
                                            searchBarText = item.shopName
                                            tapped = true
                                            coordinator.currentShopId = item.shopName
                                            coordinator.coord = (item.location.latitude, item.location.longitude)
                                            coordinator.showMarkerDetailView = true
                                            
                                            print("currentShopId : \(coordinator.currentShopId)")
                                        } label: {
                                            HStack {
                                                Image(systemName: "magnifyingglass")
                                                    .foregroundColor(.gray)
                                                
                                                // 검색어와 겹치는 단어가 있는 bottleName의 경우, 검색어와 겹치는 단어들만 accentColor
                                                // 현재는 shop을 제외한 bottleName만 리스트에 보임
                                                Text(item.shopName) { string in
                                                    if let range = string.range(of: searchBarText.trimmingCharacters(in: .whitespaces)) {
                                                        string[range].foregroundColor = Color("AccentColor")
                                                    }
                                                }
                                                .font(.bottles16)
                                                Spacer()
                                                
                                                if distance/1000 < 1 {
                                                    Text("\(String(format: "%.0f", round(distance))) m")
                                                        .font(.bottles14)
                                                        .foregroundColor(.gray)
                                                } else {
                                                    Text("\(String(format: "%.0f", round(distance/1000))) km")
                                                        .font(.bottles14)
                                                        .foregroundColor(.gray)
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                        .padding(.top, 50)
                        .padding(.bottom, 100)
//                        .padding(.leading, 10)
                        .padding(.horizontal, 30)
                        .listStyle(.plain)
                    }
                    // 해당 텍스트필드를 포커스로 키보드가 자동으로 올라오게 함
                    .onAppear {
                        showMarkerDetailView = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            focus = true
                            
                        }
                    }
                } else {
                    Text("")
                        .font(.callout)
                        .foregroundColor(Color(UIColor.systemGray3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

//struct MapSearchView_Previews: PreviewProvider {
//    static var previews: some View {
//        MapSearchView()
//    }
//}
