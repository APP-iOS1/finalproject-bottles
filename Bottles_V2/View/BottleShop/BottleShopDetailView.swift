//
//  BottleShopDetailView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopDetailView: View {
    @State private var showingSheet = true
        
    var body: some View {
        VStack{
            Button{
                showingSheet.toggle()
            }label: {
                VStack{
                    Spacer()
                        .frame(height: 200)
                    Image(systemName: "mappin")
                    Text("지도 위 바틀샵 위치 보여줌")
                    Spacer()
                }
            }
        }
        .navigationBarTitle("바틀샵 이름")
        .sheet(isPresented: $showingSheet) {
            VStack(alignment: .leading, spacing: 20){
                HStack{
                    Image(systemName: "mappin")
                    Text("서울 광진구 면목로7길 8 1층")
                }
                
                HStack{
                    Image(systemName: "house.fill")
                    Text("https://www.instagram.com/thousand_coffee_")
                }
                
                HStack{
                    Image(systemName: "phone.fill")
                    Text("0507-1347-830")
                }
                
                HStack{
                    Image(systemName: "clock.fill")
                    VStack(alignment: .leading){
                        Text("월 12:00 - 22:00")
                        Text("화 정기휴무")
                            .foregroundColor(.red)
                        Text("수 12:00 - 22:00")
                        Text("목 12:00 - 22:00")
                        Text("금 12:00 - 22:00")
                        Text("토 12:00 - 22:00")
                        Text("일 12:00 - 22:00")
                    }
                }
            }
            .font(.bottles15)
                .presentationDetents([.medium, .large])
                .presentationDragIndicator(.hidden)
                .padding(.horizontal, 5)
        }
    }
}

struct BottleShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopDetailView()
    }
}
