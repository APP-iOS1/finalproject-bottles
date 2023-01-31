//
//  ReservationPageView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

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
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        HStack {
                            // MARK: - 예약 상품 총 개수
                            Text("2건")
                                .font(.bottles16)
                                .fontWeight(.bold)
                            
                            Image("arrowBottom")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 9, height: 9)
                        }
                    }
                    
                    // MARK: - 예약 상품 리스트
                    ForEach(0..<2, id: \.self) { _ in
                        ReservationPageView_BottleCell()
                    }
                }
                .padding()
                
                // MARK: - 예약자 정보
                ReservationPageView_Info()
                
                // MARK: - 예약 체크 버튼
                Button(action: {
                    check.toggle()
                }) {
                    HStack {
                        Image(systemName: check ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 25, height: 25)
                        Text("예약 확정 후 3일 이내 미방문시 예약이 취소됩니다.")
                            .font(.bottles15)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                
                Spacer()
                
                Text("이용정책 및 개인정보 제공에 동의합니다.")
                    .font(.bottles13)
                    .fontWeight(.medium)
                
                // MARK: - 예약하기 버튼
                Button(action: {
                    if check {
                        isShowing.toggle()
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .opacity(check ? 1 : 0.5)
                            .frame(width: 358, height: 51)
                        Text("예약하기")
                            .modifier(AccentColorButtonModifier())
                    }
                }
                .padding()
                .fullScreenCover(isPresented: $isShowing) {
                    ReservedView()
                        //.accentColor(Color("AccentColor"))
                }
                // Back Button
                .navigationBarBackButtonHidden(true)
                .toolbar(content: {
                    ToolbarItem (placement: .navigationBarLeading)  {
                        Image("back")
                            .onTapGesture {
                                self.presentationMode.wrappedValue.dismiss()
                            }
                    }
                    ToolbarItem(placement: .principal) {
                        Text("예약하기")
                            .font(.bottles20)
                            .fontWeight(.medium)
                    }
                })
            }
        }
        
    }
}

//struct ReservationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView(isShowing: <#Binding<Bool>#>)
//    }
//}
