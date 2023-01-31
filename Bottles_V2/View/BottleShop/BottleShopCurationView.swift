//
//  BottleShopCurationView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 바틀샵뷰 내 "큐레이션" 뷰
struct BottleShopCurationView: View {
    @State private var selectedSort = Sort.automatic
    @State private var showingActionSheet: Bool = false
    @State private var selection = "기본순"
    
    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    // 데이터 연동 시 "shopCurationImage" 연동
                    AsyncImage(url: URL(string: "https://i0.wp.com/picjumbo.com/wp-content/uploads/new-years-toast-celebration-party-with-friends-free-photo.jpg?w=2210&quality=70")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 370)
                            .overlay{
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(.white.opacity(0.7))
                            }
                    } placeholder: {
                        Rectangle()
                            .frame(width: 370, height: 370)
                    }
                    .cornerRadius(12)
                    .foregroundColor(.white)
//                    .frame(width: 370, height: 370)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 0.7)
                    )
                    
                    
                    
                    VStack{
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            // 데이터 연동 시 "shopCurationTitle" 연동
                            Text("연말 파티에 어울리는 스파클링 와인들")
                                .font(.bottles20)
                                .fontWeight(.semibold)
                            
                            // 데이터 연동 시 "shopCurationBody" 연동
                            Text("다가오는 연말, 친구 / 연인 / 가족과 함께 \n부담없이 마시기 좋은 스파클링 와인을 추천합니다. \n어떤 음식과 페어링해도 평타 이상일 거예요!")
                                .padding(.top, 1)
                                .font(.bottles14)
                        }
                        .foregroundColor(.black)
                        .fontWeight(.medium)
                        .padding(.trailing)
                        .padding(.bottom)
                        .padding(.leading, -10)
                        .shadow(radius: 20)
                    }
                }
                
                VStack(alignment: .leading){
                    
                    // 바틀 정렬 버튼
                    HStack {
                        Spacer()
                        
                        Button {
                            showingActionSheet = true
                        } label: {
                            HStack {
                                Text("\(selection)")
                                Image(systemName: "chevron.down")
                                    .font(.system(size: 12))
                            }
                            .font(.bottles14)
                            .foregroundColor(.black)
                        }
                        .padding(.leading, 20)
                        .padding(.bottom, -10)
                    }
                    
                    // MARK: - 정렬 ActionSheet
                    .confirmationDialog("select a sort", isPresented: $showingActionSheet) {
                        Button {
                            selection = "기본순"
                        } label: {
                            Text("기본순")
                        }
                        
                        Button("신상품순") {
                            selection = "신상품순"
                        }
                        
                        Button("낮은 가격순") {
                            selection = "낮은 가격순"
                        }
                        
                        Button("높은 가격순") {
                            selection = "높은 가격순"
                        }
                    }
                    
                    // 데이터 연동 시 "큐레이션 추천 바틀" 연동
                    // 바틀 셀 반복문
                    ForEach(bottleItems, id: \.self) { item in
                        
                        // 바틀셀 누를 시 바틀뷰로 이동
                        NavigationLink(destination: BottleView(), label:{
                            BottleShopView_BottleList(selectedItem: BottleItem22(name: item.name, price: item.price, category: item.category, tag: item.tag, use: item.use))
                        })
                        
                    }
                }
            }
            .padding()
            .navigationBarTitle("바틀샵 이름")
        }
    }
}

struct BottleShopCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopCurationView()
    }
}
