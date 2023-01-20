//
//  BottleShopView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct BottleItem22: Identifiable, Hashable{
    var id = UUID()
    var name: String
    var price: String
    var category: String?
    var tag: String?
    var use: String?
}

var bottleItems: [BottleItem22] = [
    BottleItem22(name: "화이트 와인", price: "350,000원", category: "화이트", tag: "와인", use: "메인"),
    BottleItem22(name: "레드 와인", price: "400,000원", category: "레드", tag: "와인", use: "에피타이저"),
    BottleItem22(name: "스파클링 와인", price: "450,000원", category: "스파클링", tag: "와인", use: "에피타이저"),
    BottleItem22(name: "어쩌구 보드카", price: "500,000원", category: "보드카", tag: "어쩌구", use: "메인"),
    BottleItem22(name: "어쩌구 저쩌구 위스키 이름 완전 길게 쮸루룩", price: "550,000원", category: "위스키", tag: "저쩌구", use: "에피타이저")
]

enum bottleShopInfo : String, CaseIterable {
    case bottle = "상품 검색"
    case notice = "사장님의 공지"
}

struct BottleShopView: View {
    @State var text: String = ""
    @State private var bookmarkToggle = false
    @State private var isSearchView: Bool = true
    
    @State private var selectedPicker: bottleShopInfo = .bottle
    @Namespace private var animation
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 200)
                    HStack{
                        Text("바틀샵 이름")
                            .font(.bottles20)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(width: 10)
                        
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
                        
                        Image("Phone.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 15)
                            .padding(.trailing, 5)
                        
                        Spacer()
                            .frame(width: 15)
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.5)) {
                                bookmarkToggle.toggle()
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
                        Text("바틀샵 한 줄 소개 바틀샵에 오신 걸 환영합니다.")
                            .font(.bottles14)
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, -15)


                        NavigationLink(destination: BottleShopCurationView()){
                            HStack{
                                Text("연말 파티에 어울리는 스파클링 와인들")
                                Image(systemName: "chevron.right")
                                    .padding(.leading, -5)
                                Spacer()
                            }
                            .fontWeight(.semibold)
                            //                    .padding(.horizontal)
                        }
                    .font(.bottles14)
                    .padding()
                    .background(Color.accentColor.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                    .padding(.vertical, 5)
                    
                    VStack {
                        animate()
                        BottleShopInfoView(text: $text, bottleShopInfo: selectedPicker)
                    }
                    
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

struct BottleShopInfoView: View {
    @Binding var text: String
    var bottleShopInfo: bottleShopInfo
    var body: some View {
        VStack {
            switch bottleShopInfo {
            case .bottle:
                VStack(alignment: .leading){
                    BottleShopView_Search(text: $text)
                    
                    List(bottleItems.filter({ text.isEmpty ? true : $0.name.contains(text) })) { item in
                        Text(item.name)
                    }
                }
            case .notice:
                VStack{
                    BottleShopView_Notice()
                }
            }
        }
    }
}

struct BottleShopView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            BottleShopView(text: "")
        }
    }
}
