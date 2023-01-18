//
//  PickUpDetailView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpDetailView: View {
    var body: some View {
        VStack{
            HStack {
                Text("예약 번호")
                    .bold()
                Text("12345678")
                Spacer()
            }
            HStack {
                Text("픽업 매장")
                    .bold()
                Image("MapMarker")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width:15,height: 20)
                    .padding(.trailing, -5)
                Text("은노샵")
                Spacer()
            }
            .padding(.vertical)
            VStack {
                HStack {
                    Text("예약 상품")
                        .bold()
                    Spacer()
                }
                
                HStack (alignment: .top){
                    AsyncImage(url: URL(string: "https://d1e2y5wc27crnp.cloudfront.net/media/core/product/thumbnail/e8e8b60a-770c-4f67-ba67-ee3300ce0a5d.webp")) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 130, height: 130)
                    
                    } placeholder: {
                        Rectangle()
                            .frame(width: 130, height: 130)
                    }
                    VStack(alignment: .leading){
                        Text("디 오리니널 골드바 위스키")
                        Text("10,9000원")
                            .padding(.vertical, 1)
                            .bold()
                        Text("1개")
                    }
                    Spacer()
                } // 예약 상품 세부 HStack
            } // 예약 상품 VStack
            
            HStack {
                Text("예약 상태")
                    .bold()
                Text("예약 확정")
                Text("1월 21일까지 방문해주세요")
                    .font(.caption)
                    .foregroundColor(.gray)
                Spacer()
            }
            .padding(.top)
            .padding(.bottom, 50)
            NavigationLink(destination: Text("바틀샵 디테일 뷰")){
                Text("이 바틀샵의 다른 상품 보러가기")
                    .bold()
                    .foregroundColor(.white)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.accentColor)
                            .frame(width: 360, height: 50)
                    }
            }
            Spacer()
        }
        .padding()
        .navigationTitle("예약 내역 상세")
    }
}

struct PickUpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpDetailView()
    }
}
