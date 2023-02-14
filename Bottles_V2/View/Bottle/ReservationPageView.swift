//
//  ReservationPageView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 예약페이지
/// 예약한 상품 리스트 및 예약자 정보를 확인하는 뷰 입니다.
struct ReservationPageView: View {
    //@EnvironmentObject var path: Path
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var reservationDataStore: ReservationDataStore
    @EnvironmentObject var userStore: UserStore
    @EnvironmentObject var cartStore: CartStore
    @EnvironmentObject var bottleDataStore: BottleDataStore
    @State private var check: Bool = false
    @State private var isShowing: Bool = false
    @State private var hiddenBottle: Bool = false
    @State private var hiddenInfo: Bool = false
    var tempId: String = UUID().uuidString
    let bottleReservations: [BottleReservation]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    VStack(alignment: .leading, spacing: 13) {
                        HStack(alignment: .top) {
                            Text("예약 정보")
                                .font(.bottles16)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            Button(action: {
                                hiddenInfo.toggle()
                            }) {
                                Image(hiddenBottle ? "arrowTop" : "arrowBottom")
                                    .resizable()
                                    .frame(width: 10, height: 6)
                            }
                        }
                        
                        if !hiddenInfo {
                            HStack {
                                Text("픽업 매장")
                                    .font(.bottles14)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                Image("Maptabfill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 14, height: 17)
                                
                                // MARK: - 바틀샵 이름
                                Text(bottleReservations.first!.shop)
                                    .font(.bottles14)
                                    .fontWeight(.regular)
                            }
                            
                            HStack {
                                Text("예약 날짜")
                                    .font(.bottles14)
                                    .fontWeight(.medium)
                                
                                Spacer()
                                
                                // MARK: - 예약 날짜
                                Text("\(setDateFormat())까지 방문")
                                    .font(.bottles14)
                                    .fontWeight(.regular)
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Divider()
                        .padding(.vertical, 3)
                    
                    VStack(alignment: .leading) {
                        HStack {
                            Text("예약 상품")
                                .font(.bottles16)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            HStack {
                                // MARK: - 예약 바틀 총 개수
                                Text("\(bottleReservations.count)건")
                                    .font(.bottles16)
                                    .fontWeight(.medium)
                                
                                Button(action: {
                                    hiddenBottle.toggle()
                                }) {
                                    Image(hiddenBottle ? "arrowTop" : "arrowBottom")
                                        .resizable()
                                        .frame(width: 10, height: 6)
                                }
                            }
                        }
                        .padding(.bottom, 5)
                        
                        if !hiddenBottle {
                            // MARK: - 예약 바틀 리스트
                            ForEach(bottleReservations, id: \.self) { bottleReservation in
                                // 예약 바틀 셀
                                ReservationPageView_BottleCell(bottleReservation: bottleReservation)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
               
                
                Divider()
                
                // MARK: - 예약 체크 버튼
                HStack {
                    VStack(alignment: .leading, spacing: 7) {
                        Text("예약 정책에 대해 확인하였습니다.")
                            .font(.bottles14)
                            .fontWeight(.medium)
                        Text("예약 확정 후 3일 이내 미방문시 예약이 취소됩니다.")
                            .font(.bottles13)
                            .fontWeight(.regular)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        check.toggle()
                    }) {
                        Image(systemName: check ? "checkmark.square.fill" : "checkmark.square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(check ? Color("AccentColor") : .gray)
                    }
                }
                .padding()
            }
            
            VStack(spacing: 8) {
                Text("이용정책 및 개인정보 제공에 동의합니다.")
                    .foregroundColor(.black.opacity(0.5))
                    .font(.bottles12)
                    .fontWeight(.medium)
                
                // MARK: - 예약하기 버튼
                Button(action: {
                    // 예약확정 체크 시
                    if check {
                        isShowing.toggle()
                        Task{
                            await reservationDataStore.createReservation(reservationData: ReservationModel(id: UUID().uuidString, shopId: bottleReservations[0].shop, userId: userStore.user.email, reservedTime: "", state: "예약접수", reservedBottles: []), reservedBottles: bottleReservations)
                            if getBottleReservation(carts: cartStore.carts) == bottleReservations {
                                cartStore.deleteAllCart(userEmail: userStore.user.email)
                            }
                        }
                        userStore.addUserReservation(reservationId: tempId)
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .frame(width: 358, height: 56)
                        Text("예약하기")
                            .modifier(AccentColorButtonModifier())
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 30)
                .disabled(!check)
            }
            .frame(alignment: .bottom)
            
            // 예약 완료 뷰로 이동
            .navigationDestination(isPresented: $isShowing) {
                ReservedView(reservationData: ReservationModel(id: tempId, shopId: bottleReservations[0].shop, userId: userStore.user.email, reservedTime: "", state: "예약접수중", reservedBottles: getReservedBottlesArray(bottleReservations: bottleReservations)))
                //.environmentObject(path)
            }
            .toolbar(content: {
                ToolbarItem(placement: .principal) {
                    Text("예약하기")
                        .font(.bottles18)
                        .fontWeight(.medium)
                }
            })
        }
        .edgesIgnoringSafeArea([.bottom])
    }
    
    func getBottleModel(bottleId: String) -> BottleModel {
        let matchedBottleData = bottleDataStore.bottleData.filter {
            $0.id == bottleId
        }
        
        return matchedBottleData[0]
    }
    
    func getBottleReservation(carts: [Cart]) -> [BottleReservation] {
        var matchedBottleReservation: [BottleReservation] = []
        var bottleModel: BottleModel
        
        for cart in carts {
            bottleModel = getBottleModel(bottleId: cart.bottleId)
            matchedBottleReservation.append(BottleReservation(id: cart.bottleId, image: bottleModel.itemImage, title: bottleModel.itemName, price: cart.eachPrice * cart.itemCount, count: cart.itemCount, shop: cart.shopName))
        }
        
        return matchedBottleReservation
    }
    
    func getReservedBottlesArray(bottleReservations: [BottleReservation]) -> [ReservedBottles] {
        var reservedBottles: [ReservedBottles] = []
        for bottleReservation in bottleReservations {
            reservedBottles.append(ReservedBottles(id: UUID().uuidString, BottleId: bottleReservation.id, itemCount: bottleReservation.count))
        }
        return reservedBottles
    }
    
    func setDateFormat() -> String {
        let curDate = Date()
        let calender = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 d일"
        
        var day3 = DateComponents()
        day3.day = 3
        
        let curDayPlusDay3 = calender.date(byAdding: day3, to: curDate)
        let convertDate = formatter.string(from: curDayPlusDay3!)
        return convertDate
    }
}

//struct ReservationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView(isShowing: <#Binding<Bool>#>)
//    }
//}
