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
    @State private var selection = "이름순"
    @StateObject var bottleShopStore: BottleShopTestStore = BottleShopTestStore()
    
    var sortedBottleData: [BottleItem22] {
        let bottleItems: [BottleItem22] = bottleShopStore.bottleItems
        return bottleItems.sorted(by: {$0.name < $1.name})
    }
    
    func sortBottleData() -> [BottleItem22] {
        let bottleItems: [BottleItem22] = bottleShopStore.bottleItems
        switch selection {
        case "낮은 가격순":
            return bottleItems.sorted(by: {$0.name < $1.name}).sorted(by: {$0.price < $1.price})
        case "높은 가격순":
            return bottleItems.sorted(by: {$0.name < $1.name}).sorted(by: {$0.price > $1.price})
        default:
            return bottleItems.sorted(by: {$0.name < $1.name})
        }
    }

    var body: some View {
        ScrollView{
            VStack{
                ZStack{
                    // 데이터 연동 시 "shopCurationImage" 연동
                    AsyncImage(url: URL(string: "https://images.unsplash.com/photo-1591243315780-978fd00ff9db?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=2340&q=80")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 370)
                    } placeholder: {
                        Rectangle()
                            .frame(width: 370, height: 370)
                    }
                    .cornerRadius(12, corners: [.topLeft, .topRight])
                    .foregroundColor(.white)
                }
                    
                    
                    VStack{
                        
                        Spacer()
                        
                        VStack(alignment: .leading){
                            
                            // 데이터 연동 시 "shopCurationTitle" 연동
                            Text("연말 파티에 어울리는 스파클링 와인들")
                                .font(.bottles18)
                                .fontWeight(.bold)
                                .foregroundColor(.accentColor)
                                .padding(.bottom, -2)
                                .padding(.top)
                            
                            // 데이터 연동 시 "shopCurationBody" 연동
                            Text("다가오는 연말, 친구 / 연인 / 가족과 함께 \n부담없이 마시기 좋은 스파클링 와인을 추천합니다. \n어떤 음식과 페어링해도 평타 이상일 거예요!")
                                .padding(.top, 1)
                                .font(.bottles14)
                                .foregroundColor(.black)
                                .padding(.bottom)
                        }
                        .padding(.trailing)
                        .padding(.leading, -24)
                        .shadow(radius: 20)
                        .background{
                            Rectangle()
                                .frame(width: 370)
                                .foregroundColor(.purple_3)
                                .cornerRadius(12, corners: [.bottomLeft, .bottomRight])
                        }
                    }.padding(.top, -16)

                
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
                            selection = "이름순"
                        } label: {
                            Text("이름순")
                        }
                        
                        Button("낮은 가격순") {
                            selection = "낮은 가격순"
                        }
                        
                        Button("높은 가격순") {
                            selection = "높은 가격순"
                        }
                    }
                    
                    // 데이터 연동 시 "큐레이션 추천 바틀" 연동
                    // 바틀 셀(정렬 후) 반복문
                    ForEach(sortBottleData(), id: \.self) { item in
                        
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

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

struct BottleShopCurationView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopCurationView()
    }
}
