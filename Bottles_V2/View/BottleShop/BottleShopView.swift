//
//  BottleShopView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

// 임의로 바틀 아이템이 담긴 구조체 생성 (데이터 연동시 삭제)
struct BottleItem22: Identifiable, Hashable{
    var id = UUID()
    var name: String
    var price: Int
    var category: String?
    var tag: String?
    var use: String?
}

// 임의로 바틀 아이템 데이터 생성 (데이터 연동시 삭제)
var bottleItems: [BottleItem22] = [
    BottleItem22(name: "화이트 와인", price: 350000, category: "화이트", tag: "와인", use: "메인"),
    BottleItem22(name: "레드 와인", price: 400000, category: "레드", tag: "와인", use: "에피타이저"),
    BottleItem22(name: "스파클링 와인", price: 450000, category: "스파클링", tag: "와인", use: "에피타이저"),
    BottleItem22(name: "어쩌구 보드카", price: 500000, category: "보드카", tag: "어쩌구", use: "메인"),
    BottleItem22(name: "어쩌구 저쩌구 위스키 이름 완전 길게 쮸루룩", price: 550000, category: "위스키", tag: "저쩌구", use: "에피타이저")
]

// 바틀샵 뷰 내에서 [1. "상품 검색"과 2. "사장님의 공지" 뷰 이동]시 사용할 enum
enum bottleShopInfo : String, CaseIterable {
    case bottle = "상품 검색"
    case notice = "사장님의 공지"
}

// 바틀샵 메인 뷰
struct BottleShopView: View {
    
    @State private var bookmarkToggle: Bool = false
    @State private var bookmarkToggle2: Bool = false
    @State private var bookmarkToggle3: Bool = false
    @State private var isSearchView: Bool = true
    @State private var selectedPicker: bottleShopInfo = .bottle
    
    @FocusState var focus: Bool
    @State var isNavigationBarHidden: Bool = false
    @State var search: Bool = false
    @State var testSearchText: String = ""
    
    @Namespace private var animation
    
//    @Binding var mappinShopID : ShopModel
    
    // 임의로 가게 전화번호 지정 (데이터 연동시 삭제)
    var phoneNumber = "718-555-5555"
    
    // 검색 결과를 필터링해주는 연산 프로퍼티
    var filteredResult: [BottleItem22] {
        let bottles = bottleItems
        return bottles.filter {
            $0.name.contains(testSearchText)
        }
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                ScrollView{
                    VStack{
                        
                        // 데이터 연동 시 "shopTitleImage" 연동
                        AsyncImage(url: URL(string: "https://media.timeout.com/images/103625148/750/422/image.jpg")) { image in
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            Image("ready_image")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                        
                        HStack{
                            // 데이터 연동 시 "shopName" 연동
                            Text("바틀샵 이름")
                                .font(.bottles20)
                                .fontWeight(.bold)
                            
                            Spacer()
                                .frame(width: 10)
                            
                            // "매장 정보 뷰"로 이동
                            NavigationLink(destination: BottleShopDetailView())
                            {
                                HStack{
                                    Text("매장정보")
                                    Image(systemName: "chevron.right")
                                        .padding(.leading, -5)
                                }
                                .font(.bottles14)
                                .foregroundColor(.gray)
                            }
                            
                            Spacer()
                            
                            // 전화 아이콘 버튼
                            Button(action: {
                                let phone = "tel://"
                                
                                // 데이터 연동 시 "shopPhoneNumber" 연동 (phoneNumber 자리에)
                                let phoneNumberformatted = phone + phoneNumber
                                guard let url = URL(string: phoneNumberformatted) else { return }
                                UIApplication.shared.open(url)
                            }){
                                Image("Phone.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15)
                                    .padding(.trailing, 5)
                            }
                            
                            Spacer()
                                .frame(width: 15)
                            
                            // 북마크 아이콘 버튼
                            Button(action: {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    bookmarkToggle.toggle()
                                }
                                
                                if bookmarkToggle == true{
                                    withAnimation(.easeOut(duration: 1.5)) {
                                        bookmarkToggle2.toggle()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        bookmarkToggle2.toggle()
                                    }
                                }
                                
                                if bookmarkToggle == false{
                                    withAnimation(.easeOut(duration: 1.5)) {
                                        bookmarkToggle3.toggle()
                                    }
                                    
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                                        bookmarkToggle3.toggle()
                                    }
                                }
                                
                            }) {
                                Image(bookmarkToggle ? "BookMark.fill" : "BookMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15)
                                    .padding(.trailing, 5)
                            }
                            
                        }
                        .padding()
                        
                        HStack{
                            
                            // 데이터 연동 시 "shopIntroduction" 연동
                            Text("바틀샵 한 줄 소개 바틀샵에 오신 걸 환영합니다.")
                                .font(.bottles14)
                            
                            Spacer()
                        }
                        .padding(.horizontal)
                        .padding(.top, -15)
                        
                        // "큐레이션 뷰"로 이동
                        NavigationLink(destination: BottleShopCurationView()){
                            HStack{
                                
                                // 데이터 연동 시 "shopCurationTitle" 연동
                                Text("연말 파티에 어울리는 스파클링 와인들")
                                Image(systemName: "chevron.right")
                                    .padding(.leading, -5)
                                Spacer()
                            }
                            .fontWeight(.semibold)
                        }
                        .font(.bottles14)
                        .padding()
                        .background(Color.purple_3)
                        .cornerRadius(12)
                        .padding(.horizontal)
                        .padding(.vertical, 5)
                        
                        VStack {
                            animate()
                            BottleShopInfoView(bottleShopInfo: selectedPicker, search: $search, focus: _focus, isNavigationBarHidden: $isNavigationBarHidden)
                        }
                        
                    }
                }
                
                // MARK: - 상품검색 클릭시 navigationbarhidden 후 상단에 나오는 검색창
                if search {
//                    Color(.gray)
//                        .opacity(0.3)
                    VStack{
                        HStack {
                            TextField(" 이 바틀샵의 상품 검색", text: $testSearchText)
                                .focused($focus)
                                .font(.bottles16)
                                .padding(7)
                                .padding(.horizontal, 25)
                                .cornerRadius(8)
                                .overlay(
                                    HStack {
                                        Image(systemName: "magnifyingglass")
                                            .foregroundColor(.black)
                                            .font(.system(size: 18))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                            .padding(.leading, 8)
                                        
                                        Button(action: {
                                            self.testSearchText = ""
                                        }) {
                                            Image(systemName: "multiply.circle.fill")
                                                .foregroundColor(.gray)
                                                .padding(.trailing, 8)
                                        }
                                    }
                                )
                                .padding(.leading, 10)
                            
                            // 검색종료버튼(검색창, 키보드 내리기 및 네비게이션바 다시 보이게 하는 액션)
                            Button(action: {
                                search = false
                                focus = false
                                isNavigationBarHidden = false
                                self.testSearchText = ""
                                
                                // Dismiss the keyboard
                                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                                
                            }) {
                                Text("종료  ")
                                    .padding(.trailing, 20)
                            }
                            
                        }
                        .background(.white)
                        .padding(.bottom, -10)
                        
                        ScrollView {
                            ForEach(filteredResult, id: \.self) { item in
                                NavigationLink(destination: BottleView(), label:{
                                    BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                                        .padding()
                                })
                            }
                        }
                        
                        .background(Color.white)
                        
                    }
                    .transition(.asymmetric(insertion: AnyTransition.opacity.animation(.easeInOut),
                                            removal: AnyTransition.opacity.animation(.easeInOut))
                    )
                    //                    .animation(.easeOut)
                }
                
                // MARK: - "BookMark 완료"시 애니메이션
                if bookmarkToggle2{
                    HStack{
                        Image(bookmarkToggle2 ? "BookMark.fill" : "BookMark")
                        Text(bookmarkToggle2 ? "북마크가 완료되었습니다." : "북마크가 해제되었습니다.")
                            .foregroundColor(.gray)
                            .font(.bottles11)
                        
                    }
                    .zIndex(1)
                    .transition(.opacity.animation(.easeIn))
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 30)
                            .foregroundColor(.gray_f7)
                    }
                    .offset(y: 300)
                }
                
                // MARK: - "BookMark 해제"시 애니메이션
                if bookmarkToggle3{
                    HStack{
                        Image("BookMark")
                        Text("북마크가 해제되었습니다.")
                            .foregroundColor(.gray)
                            .font(.bottles11)
                        
                    }
                    .zIndex(1)
                    .transition(.opacity.animation(.easeIn))
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 300, height: 30)
                            .foregroundColor(.gray_f7)
                    }
                    .offset(y: 300)
                }
                
            }
            .navigationBarHidden(isNavigationBarHidden)
            .toolbar { // <-
                    NavigationLink {
                        SearchViewNavigationLabel()
                    } label: {
                      Label("Profile", systemImage: "person.crop.circle")
                    }
                  }
        }
    }
    
    // MARK: - Picker Animation 함수
    @ViewBuilder
    private func animate() -> some View {
        VStack {
            HStack {
                ForEach(bottleShopInfo.allCases, id: \.self) { item in
                    VStack {
                        Text(item.rawValue)
                            .kerning(-1)
                            .frame(maxWidth: 200, maxHeight: 30)
                            .foregroundColor(selectedPicker == item ? .black : .gray)
                            .padding(.top, 10)
                        
                        if selectedPicker == item {
                            Capsule()
                                .foregroundColor(.black)
                                .frame(height: 2)
                                .matchedGeometryEffect(id: "info", in: animation)
                        } else if selectedPicker != item {
                            Capsule()
                                .foregroundColor(.white)
                                .frame(height: 2)
                        }
                    }
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.1)) {
                            self.selectedPicker = item
                        }
                    }
                }
            }
            .padding(.horizontal, 15)
        }
        
    }
    
}

// 바틀샵 메인 뷰 내 [1. "상품 검색"과 2. "사장님의 공지" 뷰] 탭
struct BottleShopInfoView: View {
    var bottleShopInfo: bottleShopInfo
    
    @Binding var search: Bool
    @FocusState var focus: Bool
    @Binding var isNavigationBarHidden: Bool
    
    var body: some View {
        VStack {
            switch bottleShopInfo {
                
                // "상품 검색 탭"
            case .bottle:
                VStack(alignment: .leading){
                    BottleShopView_Search(search: $search, focus: _focus, isNavigationBarHidden: $isNavigationBarHidden)
                }
                
                // "사장님의 공지 탭"
            case .notice:
                VStack{
                    BottleShopView_Notice()
                }
            }
        }
    }
}

//struct BottleShopView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavigationStack{
//            BottleShopView()
//        }
//    }
//}
