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
    @State private var check: Bool = false
    @State private var isShowing: Bool = false
    @State private var hiddenBottle: Bool = false
    
    let bottleReservations: [BottleReservation]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
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
                                Image("arrowBottom")
                                    .resizable()
                                    .frame(width: 10, height: 6)
                            }
                        }
                    }
                    
                    if !hiddenBottle {
                        // MARK: - 예약 바틀 리스트
                        ForEach(bottleReservations, id: \.self) { bottleReservation in
                            // 예약 바틀 셀
                            ReservationPageView_BottleCell(bottleReservation: bottleReservation)
                        }
                    }
                }
                .padding()
                
                Divider()
                
                // MARK: - 예약 체크 버튼
                Button(action: {
                    check.toggle()
                }) {
                    HStack {
                        Image(systemName: check ? "checkmark.circle.fill" : "circle")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(check ? Color("AccentColor") : Color("AccentColor").opacity(0.1))
                        Text("예약 확정 후 3일 이내 미방문시 예약이 취소됩니다.")
                            .font(.bottles14)
                            .fontWeight(.medium)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 10)
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
                            await reservationDataStore.createReservation(reservationData: ReservationModel(id: UUID().uuidString, shopID: bottleReservations[0].shop, userID: userStore.user.email, reservedTime: Date.now, state: "예약중", reservedBottles: []), reservedBottles: bottleReservations)
                        }
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
                .disabled(!check)
            }
            .frame(alignment: .bottom)
            
            // 예약 완료 뷰로 이동
            .navigationDestination(isPresented: $isShowing) {
                ReservedView()
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
    }
}

//// 예약 상품 더미데이터
//var bottleReservationData = [
//    BottleReservation(image: "bottle", title: "프로메샤 모스카토", price: 110000, count: 1, shop: "와인앤모어 군자점"),
//    BottleReservation(image: "bottle2", title: "샤도네이 화이트 와인", price: 58000, count: 1, shop: "와인앤모어 군자점")
//]


//struct ReservationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView(isShowing: <#Binding<Bool>#>)
//    }
//}
