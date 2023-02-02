//
//  PickUpDetailView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpDetailView: View {
    /// 주소 복사를 했을 때 주소 복사 알림을 띄워줌
    @State private var isShowingPasted: Bool = false
    var body: some View {
        ZStack{
            VStack{
                HStack {
                    Text("예약 번호")
                        .font(.bottles15)
                        .bold()
                    Text("12345678")
                    Spacer()
                }
                .font(.bottles15)
                
                // MARK: - 픽업 매장 HStack
                HStack(alignment: .bottom) {
                    Text("픽업 매장")
                        .font(.bottles15)
                        .bold()
                    Image("MapMarker")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width:15,height: 20)
                        .padding(.trailing, -5)
                    
                    Text("은노샵")
                        .font(.bottles15)
                    
                    // MARK: - 픽업 매장 HStack내의 주소복사 버튼
                    Button(action: {
                        copyToClipboard()
                        isShowingPasted.toggle()
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
                            isShowingPasted.toggle()
                        }
                        
                    }){
                        Text("주소 복사")
                            .font(.bottles12)
                    }
                    Spacer()
                }
                .padding(.vertical)
                // MARK: - 예약 상품 VStack
                VStack {
                    HStack {
                        Text("예약 상품")
                            .bold()
                        Spacer()
                    }
                    // MARK: - 예약 세부 상품 HStack
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
                            Text("디 오리지널 골드바 위스키")
                                .font(.bottles13)
                            Text("10,9000원")
                                .font(.bottles15)
                                .padding(.vertical, 1)
                                .bold()
                            Text("1개")
                                .font(.bottles13)
                        }
                        Spacer()
                    }
                }
                // MARK: - 예약상태 HStack
                HStack {
                    Text("예약 상태")
                        .font(.bottles15)
                        .bold()
                    Text("예약 확정")
                        .font(.bottles15)
                    Text("1월 21일까지 방문해주세요")
                        .font(.bottles12)
                        .foregroundColor(.gray)
                    Spacer()
                }
                .padding(.top)
                .padding(.bottom, 50)
                
                //MARK: - 다른 샵 보러가기 버튼
                NavigationLink(destination: BottleShopView()){
                    Text("이 바틀샵의 다른 상품 보러가기")
                        .font(.bottles18)
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
            
            //MARK: - 주소복사 버튼 눌렀을 시 뜨는 알림
            if isShowingPasted{
                Text("주소 복사 완료")
                    .foregroundColor(.white)
                    .font(.caption)
                    .background{
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 200, height: 30)
                            .opacity(0.3)
                    }
                    .position(x: 195, y: 600)
                
            }
        }
    }
    
    // Todo: 데이터가 구성된 뒤 복사할 텍스트를 매개변수로 받아서 처리하기
    func copyToClipboard() {
        UIPasteboard.general.string = "은노샵"
    }
}

struct PickUpDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpDetailView()
    }
}
