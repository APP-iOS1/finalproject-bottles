//
//  ReservationPageView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct ReservationPageView: View {
    @State private var check: Bool = false
    @State private var isShowing: Bool = false
    @Binding var dismiss: Bool
    
    
    var body: some View {
        NavigationStack {
            HStack {
                Button(action: {
                    dismiss.toggle()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                Text("예약하기")
                    .font(.system(size: 20, weight: .medium))
                Spacer()
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                // 예약 상품
                HStack {
                    Text("예약 상품")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    HStack {
                        Text("2건")
                            .font(.callout)
                            .fontWeight(.bold)
                        
                        Image("arrowBottom")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 9, height: 9)
                    }
                }
                
                ForEach(0..<2, id: \.self) { _ in
                    HStack {
                        Image("kilchoman")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 129, height: 129)
                            .background(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                        VStack(alignment: .leading, spacing: 5) {
                            Text("킬호만 샤닉")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("350,000원")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("1개")
                                .font(.subheadline)
                                .fontWeight(.medium)
                            
                            Spacer()
                            
                            HStack {
                                Image("location")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 11, height: 16)
                                Text("바틀샵 이름")
                                    .font(.subheadline)
                                    .fontWeight(.medium)
                            }
                        }
                        .padding(10)
                    }
                    .frame(height: 129)
                }
            }
            .padding()
            
            VStack(alignment: .leading, spacing: 15) {
                
                // 예약자 정보
                HStack {
                    Text("예약자 정보")
                        .font(.callout)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Image("arrowBottom")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 9, height: 9)
                }
                VStack(alignment: .leading, spacing: 7) {
                    HStack {
                        Text("이름")
                        Text("안은노")
                    }
                    HStack {
                        Text("전화번호")
                        Text("010-0000-0000")
                    }
                    HStack {
                        Text("생년월일")
                        Text("1994-00-00")
                    }
                }
                .font(.subheadline)
                .fontWeight(.medium)
            }
            .padding()
                
            Button(action: {
                check.toggle()
            }) {
                HStack {
                    Image(systemName: check ? "checkmark.square.fill" : "square")
                        .resizable()
                        .frame(width: 25, height: 25)
                    Text("예약 확정 후 3일 이내 미방문시 예약이 취소됩니다.")
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
            
            Spacer()
            
            Text("이용정책 및 개인정보 제공에 동의합니다.")
                .font(.footnote)
                .fontWeight(.medium)
            
            Button(action: {
                if check {
                    isShowing.toggle()
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.gray)
                        .frame(width: 358, height: 51)
                    Text("예약하기")
                        .font(.system(size: 18, weight: .bold))
                }
            }
            .padding()
            .navigationDestination(isPresented: $isShowing) {
                ReservedView()
            }
        }
        
    }
}

//struct ReservationPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationPageView(isShowing: <#Binding<Bool>#>)
//    }
//}
