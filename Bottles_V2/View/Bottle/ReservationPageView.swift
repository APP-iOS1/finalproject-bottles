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
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var check: Bool = false
    @State private var isShowing: Bool = false
    
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
                            Text("2건")
                                .font(.bottles16)
                                .fontWeight(.medium)
                            
                            Image("arrowBottom")
                                .resizable()
                                .frame(width: 10, height: 6)
                        }
                    }
                    
                    // MARK: - 예약 바틀 리스트
                    ForEach(bottleReservationData, id: \.self) { bottle in
                        // 예약 바틀 셀
                        ReservationPageView_BottleCell(bottleReservation: bottle)
                    }
                }
                .padding()
                
                Divider()
                
                // MARK: - 예약자 정보
                ReservationPageView_Info()
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                
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
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 12)
                            .opacity(check ? 1 : 0.5)
                            .frame(width: 358, height: 56)
                        Text("예약하기")
                            .modifier(AccentColorButtonModifier())
                    }
                }
                .padding(.horizontal)
            }
            .frame(alignment: .bottom)
            //.padding(.top, 55)
            // 예약 완료 뷰로 이동
            .navigationDestination(isPresented: $isShowing) {
                ReservedView()
                    //.accentColor(Color("AccentColor"))
            }
            // Back Button
    //                .navigationBarBackButtonHidden(true)
            .toolbar(content: {
    //                    ToolbarItem (placement: .navigationBarLeading)  {
    //                        Image("back")
    //                            .onTapGesture {
    //                                self.presentationMode.wrappedValue.dismiss()
    //                            }
    //                    }
                ToolbarItem(placement: .principal) {
                    Text("예약하기")
                        .font(.bottles18)
                        .fontWeight(.medium)
                }
            })
        }
       
        
    }
}

// 예약 상품 샘플 구조체
struct Bottle_reservation: Hashable {
    var image: String
    var title: String
    var price: Int
    var count: Int
    var shop: String
}

// 예약 상품 더미데이터
var bottleReservationData = [
    Bottle_reservation(image: "bottle", title: "프로메샤 모스카토", price: 110000, count: 1, shop: "와인앤모어 군자점"),
    Bottle_reservation(image: "bottle2", title: "샤도네이 화이트 와인", price: 58000, count: 1, shop: "와인앤모어 군자점")
]


//struct ReservationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView(isShowing: <#Binding<Bool>#>)
//    }
//}
