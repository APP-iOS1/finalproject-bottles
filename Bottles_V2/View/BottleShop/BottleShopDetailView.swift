//
//  BottleShopDetailView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 바틀샵뷰 내 "매장 정보" 뷰
struct BottleShopDetailView: View {
    
    var body: some View {
        ScrollView{
            // 데이터 연동 시 "바틀샵 위치" 연동
            // 맵뷰 위에 핀 띄워줘야 함
            VStack{
                Text("해당 바틀샵 맵뷰")
            }
            .frame(height: 442)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 20){
                
                Spacer()
                    .frame(height: 1)
                
                HStack{
                    Image("Mappin.bottleshop")
                    
                    // 데이터 연동 시 "바틀샵 주소" 연동
                    Text("서울 광진구 면목로7길 8 1층")
                    
                    // 복사하기 버튼
                    
                    Button{
                        copyToClipboard_Address()
                    } label:{
                        Text("주소 복사")
                            .foregroundColor(.gray)
                            .font(.bottles12)
                    }
                }
                
                HStack{
                    Image("House.bottleshop")
                    
                    // 데이터 연동 시 "바틀샵 sns" 연동
                    Text("https://www.instagram.com/thousand_coffee_")
                }
                
                HStack{
                    Image("Phone.bottleshop")
                    
                    // 데이터 연동 시 "바틀샵 연락처" 연동
                    Text("0507-1347-830")
                    
                    Button{
                        copyToClipboard_PhoneNumber()
                    } label:{
                        Text("연락처 복사")
                            .foregroundColor(.gray)
                            .font(.bottles12)
                    }
                    
                }
                
                HStack{
                    VStack{
                        Image("Clock.bottleshop")
                        Spacer()
                    }
                    // 데이터 연동 시 "바틀샵 운영시간" 연동
                    VStack(alignment: .leading){
                        Text("월 12:00 - 22:00")
                        Text("화 정기휴무")
                        Text("수 12:00 - 22:00")
                        Text("목 12:00 - 22:00")
                        Text("금 12:00 - 22:00")
                        Text("토 12:00 - 22:00")
                        Text("일 12:00 - 22:00")
                    }
                }
                
                Spacer()
                    .frame(height: 1)
                
            }
            .font(.bottles15)
            .padding(.horizontal, 5)
            
        }
        // 데이터 연동 시 "바틀샵 이름" 연동
        .navigationBarTitle("바틀샵 이름")
//        .sheet(isPresented: $showingSheet) {
//
//        }
    }
    
    // MARK: - "주소 복사"시 사용하는 함수
    func copyToClipboard_Address() {
        // 데이터 연동 시 "바틀샵 주소" 연동
        UIPasteboard.general.string = "서울 광진구 면목로7길 8 1층"
        
        print("주소 복사하기 완료")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//            self.buttonText = "Copy to clipBoard"
//        }
    }
    
    
    // MARK: - "연락처 복사"시 사용하는 함수
    func copyToClipboard_PhoneNumber() {
        // 데이터 연동 시 "바틀샵 연락처" 연동
        UIPasteboard.general.string = "0507-1347-830"
        
        print("복사하기 완료")
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//            self.alert(title: Text("연락처 복사가 완료되었습니다."))
//        }
    }
    
}

struct BottleShopDetailView_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopDetailView()
    }
}
