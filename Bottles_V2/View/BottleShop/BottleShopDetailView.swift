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
    
    //    @Binding var mappinShopID : ShopModel
    
    /// 주소 복사를 했을 때 주소 복사 알림을 띄워줌
    @State private var isShowingPasted_Address: Bool = false
    @State private var isShowingPasted_PhoneNumber: Bool = false
    
    var bottleShop: ShopModel
    @State var today: String = ""
    
    var body: some View {
        
        ZStack{
            ScrollView{
                // 데이터 연동 시 "바틀샵 위치" 연동
                // 맵뷰 위에 핀 띄워줘야 함
                VStack{
                    VStack{
                        Text("bottleshop 위치")
                        //                NaverMap((37.56668, 126.978419), .constant(false), $mappinShopID)
                    }
                    .frame(height: 442)
                    
                    Divider()
                    
                    VStack(alignment: .leading, spacing: 20){
                        
                        Spacer()
                            .frame(height: 1)
                        
                        HStack{
                            VStack{
                                Image("Mappin.bottleshop")
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
                                Image("House.bottleshop")
                            }
                            // 데이터 연동 시 "바틀샵 sns" 연동
                            Text(bottleShop.shopSNS)
                        }
                        
                        HStack{
                            VStack{
                                Image("Phone.bottleshop")
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
                                let shopOpenCloseTime = bottleShop.shopOpenCloseTime
                                let seperatedshopOpenCloseTime = shopOpenCloseTime.components(separatedBy: ["|"])
                                
                                ForEach(seperatedshopOpenCloseTime, id: \.self){ time in
                                    let dayOpenCloseTime = time.components(separatedBy: ["/"])
                                    
                                    if dayOpenCloseTime[1] == dayOpenCloseTime[2]{
                                        HStack{
                                            if dayOpenCloseTime[0] == self.today {
                                                Text("\(dayOpenCloseTime[0])")
                                                    .fontWeight(.bold)
                                                
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
                                            if dayOpenCloseTime[0] == self.today {
                                                Text("\(dayOpenCloseTime[0])")
                                                    .fontWeight(.bold)
                                                Text("\(dayOpenCloseTime[1]) ~ \(dayOpenCloseTime[2])")
                                                    .fontWeight(.bold)
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
                    .padding(.horizontal, 5)
                }
            }
        }
        .onAppear(){
            koreanDate()
        }
        // 데이터 연동 시 "바틀샵 이름" 연동
        .navigationBarTitle("바틀샵 이름")
        //        .sheet(isPresented: $showingSheet) {
        //
        //        }
        
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
                Image("Phone.bottleshop")
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
    
    // MARK: - 대한민국 날짜 계산
    func koreanDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.setLocalizedDateFormatFromTemplate("EEEE")
        var dayInKorean = dateFormatter.string(from: date)
        today = String(dayInKorean[0])
        
        print("Today is \(dayInKorean) in Korean")
    }
    
    
}

//struct BottleShopDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopDetailView()
//    }
//}
