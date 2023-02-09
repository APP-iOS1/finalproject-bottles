//
//  BottleShopDetailView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI
import Foundation

// 바틀샵뷰 내 "매장 정보" 뷰
struct BottleShopDetailView: View {
    
    // 주소 복사를 했을 때 주소 복사 알림을 띄워줌
    @State private var isShowingPasted_Address: Bool = false
    
    // 연락처 복사를 했을 때 연락처 복사 알림을 띄워줌
    @State private var isShowingPasted_PhoneNumber: Bool = false
    
    var bottleShop: ShopModel
    @State var today: String = ""
    
    var body: some View {
        
        ZStack{
            ScrollView{
                // 데이터 연동 시 "바틀샵 위치" 연동
                // 맵뷰 위에 핀 띄워줘야 함
                VStack(alignment: .leading){
                    HStack{
                        Spacer()
                        Text("bottleshop 위치")
                        //                NaverMap((37.56668, 126.978419), .constant(false), $mappinShopID)
                        Spacer()
                    }
                    .frame(height: 442)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        Spacer()
                            .frame(height: 1)
                        
                        HStack{
                            VStack{
                                VStack{
                                    Image("Mappin.bottleshop")
                                }
                                Spacer()
                            }
                            // 데이터 연동 시 "바틀샵 주소" 연동
                            Text(bottleShop.shopAddress)
                            
                            // 복사하기 버튼
                            
                            Button{
                                copyToClipboard_Address()
                                
                                isShowingPasted_Address.toggle()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                    isShowingPasted_Address.toggle()
                                }
                            } label:{
                                Text("주소 복사")
                                    .foregroundColor(.gray)
                                    .font(.bottles12)
                            }
                        }
                        
                        HStack{
                            VStack{
                                VStack{
                                    Image("House.bottleshop")
                                }
                                Spacer()
                            }
                            // 데이터 연동 시 "바틀샵 sns" 연동
                            Text(bottleShop.shopSNS)
                        }
                        
                        HStack{
                            VStack{
                                VStack{
                                    Image(systemName: "phone.fill")
                                        .foregroundColor(.purple_2)
                                        .font(.bottles16)
                                }
                                Spacer()
                            }
                            // 데이터 연동 시 "바틀샵 연락처" 연동
                            Text(bottleShop.shopPhoneNumber)
                            
                            Button{
                                copyToClipboard_PhoneNumber()
                                
                                isShowingPasted_PhoneNumber.toggle()
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0){
                                    isShowingPasted_PhoneNumber.toggle()
                                }
                            } label:{
                                Text("연락처 복사")
                                    .foregroundColor(.gray)
                                    .font(.bottles12)
                            }
                        }
                        
                        HStack{
                            VStack{
                                VStack{
                                    Image("Clock.bottleshop")
                                }
                                Spacer()
                            }
                            
                            // 데이터 연동 시 "바틀샵 운영시간" 연동
                            VStack(alignment: .leading){
                                
                                // 바틀샵 운영시간 받아옴
                                let shopOpenCloseTime = bottleShop.shopOpenCloseTime
                                
                                // 바틀샵 운영시간(문자열)을 요일별로 나눌 때 사용한 "|" 문자 기준으로, 문자열을 배열로 separate시킴
                                let seperatedshopOpenCloseTime = shopOpenCloseTime.components(separatedBy: ["|"])
                                
                                ForEach(seperatedshopOpenCloseTime, id: \.self){ time in
                                    
                                    // 바틀샵 운영시간(문자열)을 오픈시간/클로즈시간 별로 나눌 때 사용한 "/" 문자 기준으로, 문자열을 배열로 separate시킴
                                    let dayOpenCloseTime = time.components(separatedBy: ["/"])
                                    
                                    // 바틀샵 오픈시간[1]과 클로즈시간[2]이 같을 시 휴무일로 지정
                                    if dayOpenCloseTime[1] == dayOpenCloseTime[2]{
                                        HStack{
                                            
                                            // 해당 요일[0]이 오늘의 요일과 같을 때
                                            if dayOpenCloseTime[0] == self.today {
                                                Text("\(dayOpenCloseTime[0])")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.accentColor)
                                                
                                                Text("휴무일")
                                                    .foregroundColor(.red)
                                                    .fontWeight(.bold)
                                            } else{
                                                Text("\(dayOpenCloseTime[0])")
                                                Text("휴무일")
                                                    .foregroundColor(.red)
                                            }
                                            
                                        }
                                    }else{
                                        HStack{
                                            // 해당 요일[0]이 오늘의 요일과 같을 때
                                            if dayOpenCloseTime[0] == self.today {
                                                Text("\(dayOpenCloseTime[0])")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.accentColor)
                                                Text("\(dayOpenCloseTime[1]) ~ \(dayOpenCloseTime[2])")
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.accentColor)
                                            } else{
                                                Text("\(dayOpenCloseTime[0])")
                                                Text("\(dayOpenCloseTime[1]) ~ \(dayOpenCloseTime[2])")
                                            }
                                            
                                        }
                                    }
                                }
                            }
                        }
                        
                        Spacer()
                            .frame(height: 1)
                        
                    }
                    .font(.bottles15)
                    .padding(.horizontal, 15)
                }
                
            }
        }
        .onAppear(){
            // 대한민국의 날짜(요일) 계산
            koreanDate()
        }
        
        // 데이터 연동 시 "바틀샵 이름" 연동
        .navigationBarTitle("바틀샵 이름")
        
        //MARK: - 주소복사 버튼 눌렀을 시 뜨는 알림
        
        if isShowingPasted_Address{
            HStack{
                Image("Mappin.bottleshop")
                Text("주소 복사가 완료되었습니다.")
                    .foregroundColor(.black)
                    .font(.caption)
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 30)
                    .foregroundColor(.gray_f7)
            }
            .offset(y: -30)
            
        }
        
        //MARK: - 연락처 복사 버튼 눌렀을 시 뜨는 알림
        if isShowingPasted_PhoneNumber{
            HStack{
                Image(systemName: "phone.fill")
                    .foregroundColor(.purple_2)
                    .padding(.trailing, -4)
                
                Text("연락처 복사가 완료되었습니다.")
                    .foregroundColor(.black)
                    .font(.caption)
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 30)
                    .foregroundColor(.gray_f7)
            }
            .offset(y: -30)
        }
        
    }
    
    // MARK: - "주소 복사"시 사용하는 함수
    func copyToClipboard_Address() {
        // 데이터 연동 시 "바틀샵 주소" 연동
        UIPasteboard.general.string = bottleShop.shopAddress
        
        print("주소 복사하기 완료")
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
        //            self.buttonText = "Copy to clipBoard"
        //        }
    }
    
    
    // MARK: - "연락처 복사"시 사용하는 함수
    func copyToClipboard_PhoneNumber() {
        // 데이터 연동 시 "바틀샵 연락처" 연동
        UIPasteboard.general.string = bottleShop.shopPhoneNumber
        
        print("연락처 복사하기 완료")
        
        //        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
        //            self.alert(title: Text("연락처 복사가 완료되었습니다."))
        //        }
    }
    
    // MARK: - 대한민국의 날짜(요일) 계산
    func koreanDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        let dayInKorean = dateFormatter.string(from: date)
        today = String(dayInKorean[0])
        
        print("Today is \(dayInKorean) in Korean")
    }
    
    
}

//struct BottleShopDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopDetailView()
//    }
//}
