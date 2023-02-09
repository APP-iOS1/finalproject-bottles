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
    @State var searchBarText: String = "" // 텍스트필드에 입력되는 텍스트
    @State var doneTextFieldEdit: Bool = false
    @FocusState var focusField: FocusField? // 포커스된 텍스트필드
    @Binding var tapped: Bool // MapView에서의 텍스트 필드의 tap여부를 바인딩으로 넘김
    
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
                            
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.black)
                                    .font(.system(size: 18))
                                // 검색바 TextField
                                // onEditingChanged : TextField 편집 상태를 bool값으로 받는다
                                // onCommit : TextField 작업 중 Return 키를 누를 때 수행할 작업
                                TextField("원하는 술, 바틀샵 검색", text: $searchBarText, onEditingChanged: { bool in
                                    if bool {
                                        doneTextFieldEdit = false
                                    } else {
                                        doneTextFieldEdit = true
                                    }
                                }, onCommit: {
                                    doneTextFieldEdit = true
                                })
                                .font(.bottles16)
                                .multilineTextAlignment(.leading)
                                .submitLabel(.search)
                                .focused($focusField, equals: .field)
                                
                                if !searchBarText.isEmpty {
                                    Button(action: {
                                        self.searchBarText = ""
                                        //focus = false
                                    }) {
                                        Image(systemName: "xmark.circle.fill")
                                    }
                                } else {
                                    EmptyView()
                                }
                            }
                            .padding(10)
                            .frame(width: 250, height: 35)
                            .background{
                                Color.gray_f7
                            }
                            .cornerRadius(12)
                        }
                    }
                    // 해당 텍스트필드를 포커스로 키보드가 자동으로 올라오게 함
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            focusField = .field
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
