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
                    BottleItem22(name: "저쩌구 위스키", price: "550,000원", category: "위스키", tag: "저쩌구", use: "에피타이저")
                            ]

struct BottleShopView: View {
    @State var text: String = ""
    @State private var bookmarkToggle = false
    @State private var isSearchView: Bool = true
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    Rectangle()
                        .foregroundColor(.gray)
                        .frame(height: 200)
                    HStack{
                        Text("바틀샵 이름")
                            .font(.system(size: 22))
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
                            .font(.system(size: 15))
                            .foregroundColor(.black)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "phone.fill")
                            .font(.system(size: 22))
                        
                        Spacer()
                            .frame(width: 15)
                        
                        Button(action: {
                            withAnimation(.easeOut(duration: 0.5)) {
                                bookmarkToggle.toggle()
                            }
                        }) {
                            Image(systemName: bookmarkToggle ? "bookmark.fill" : "bookmark")
                                .font(.system(size: 22))
                                .foregroundColor(.black)
                        }
                        
                    }
                    .padding()
                    
                    HStack{
                        Text("바틀샵 한 줄 소개 바틀샵에 오신 걸 환영합니다.")
                            .font(.system(size: 15))
                            .foregroundColor(Color(UIColor.systemGray))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.top, -10)
                    .padding(.bottom, 15)
                    
                    VStack{
                        HStack(alignment: .center){
                            VStack{
                                Button(action: {
                                    isSearchView = true
                                }) {
                                    VStack{
                                        Text("상품 검색")
                                            .foregroundColor(isSearchView ? .black : .gray)
                                        
                                        Rectangle()
                                            .frame(height: 2)
                                            .foregroundColor(isSearchView ? .black : .gray)
                                            .padding(.trailing, -4)
                                    }
                                }
                                
                            }
                            
                            Button(action: {
                                isSearchView = false
                            }) {
                                VStack{
                                    Text("사장님의 공지")
                                        .foregroundColor(isSearchView ? .gray : .black)
                                    
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(isSearchView ? .gray : .black)
                                        .padding(.leading, -4)
                                }
                                
                            }
                        }
                        
                        if isSearchView {
                            VStack(alignment: .leading){
                                BottleShopView_Search(text: $text)
                                
                                List(bottleItems.filter({ text.isEmpty ? true : $0.name.contains(text) })) { item in
                                    Text(item.name)
                                }
                            }
                            
                        } else {
                            VStack{
                                BottleShopView_Notice()
                            }
                            
                        }
                    }
                    .padding(.top)
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
