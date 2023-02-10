//
//  MapSearchView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/08.
//

import SwiftUI

struct MapSearchView: View {
    // 뷰 이동 시 해당 텍스트필드에 키보드 포커스
    enum FocusField: Hashable {
        case field
    }
    @Binding var searchBarText: String // 텍스트필드에 입력되는 텍스트
    @State var doneTextFieldEdit: Bool = false
    @FocusState var focus: Bool  // 포커스된 텍스트필드
    @Binding var tapped: Bool // MapView에서의 텍스트 필드의 tap여부를 바인딩으로 넘김
    @EnvironmentObject var mapViewModel: MapViewModel
    @EnvironmentObject var shopDataStore: ShopDataStore
    @Binding var showMarkerDetailView: Bool
//    @Binding var mapSearchBarText: String
    @Binding var searchResult: [ShopModel]
    @Binding var currentShopId: String
    @Binding var tapSearchButton: Bool
    var body: some View {
        NavigationStack {
            ZStack {
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
                                .padding(5)
                            
                            MapViewSearchBar(showMarkerDetailView: $showMarkerDetailView, searchBarText: $searchBarText, searchResult: $searchResult, currentShopId: $currentShopId, tapSearchButton: $tapSearchButton)
                            
                            //                            HStack {
                            //                                Image(systemName: "magnifyingglass")
                            //                                    .foregroundColor(.black)
                            //                                    .font(.system(size: 18))
                            //                                // 검색바 TextField
                            //                                // onEditingChanged : TextField 편집 상태를 bool값으로 받는다
                            //                                // onCommit : TextField 작업 중 Return 키를 누를 때 수행할 작업
                            //                                TextField("원하는 술, 바틀샵 검색", text: $searchBarText, onEditingChanged: { bool in
                            //                                    if bool {
                            //                                        doneTextFieldEdit = false
                            //                                    } else {
                            //                                        doneTextFieldEdit = true
                            //                                    }
                            //                                }, onCommit: {
                            //                                    doneTextFieldEdit = true
                            //                                })
                            //                                .font(.bottles16)
                            //                                .multilineTextAlignment(.leading)
                            //                                .submitLabel(.search)
                            //                                .focused($focusField, equals: .field)
                            //
                            //                                if !searchBarText.isEmpty {
                            //                                    Button(action: {
                            //                                        self.searchBarText = ""
                            //                                        //focus = false
                            //                                    }) {
                            //                                        Image(systemName: "xmark.circle.fill")
                            //                                    }
                            //                                } else {
                            //                                    EmptyView()
                            //                                }
                            //                            }
                            //                                .padding(10)
                            //                                .frame(width: 250, height: 35)
                            
                            //                                .cornerRadius(12)
                        }
                        //                        .frame(width: 300)
                        .padding(10)
                        .offset(y: 30)
                        //                        Spacer()
                        // 여기서 검색 리스트 구현
                        List {
                            ForEach (searchResult, id: \.self) { item in
                                // 검색어와 겹치는 단어가 있는지 없는지 확인
                                if item.shopName.replacingOccurrences(of: " ", with: "").contains(searchBarText.replacingOccurrences(of: " ", with: "")) {
                                    Button {
                                        doneTextFieldEdit = true
                                        
                                        // 사용자가 리스트에서 찾고자하는 단어가 있어 터치 시, 해당 단어를 검색창의 텍스트로 전환
                                        searchBarText = item.shopName
                                        
                                    } label: {
                                        HStack {
                                            Image(systemName: "magnifyingglass")
                                                .foregroundColor(.gray)
                                                .padding([.leading, .trailing])
                                            
                                            // 검색어와 겹치는 단어가 있는 bottleName의 경우, 검색어와 겹치는 단어들만 accentColor
                                            // 현재는 shop을 제외한 bottleName만 리스트에 보임
                                            Text(item.shopName) { string in
                                                if let range = string.range(of: searchBarText.trimmingCharacters(in: .whitespaces)) {
                                                    string[range].foregroundColor = Color("AccentColor")
                                                }
                                            }
                                            .font(.bottles16)
                                            Spacer()
                                            
                                            Image("Map_tab_fill")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 16, height: 16)
                                            
                                        }
                                    }
                                }
                            }
                        }
                        .padding(10)
                        .listStyle(.plain)
                    }
                    // 해당 텍스트필드를 포커스로 키보드가 자동으로 올라오게 함
                    .onAppear {
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
