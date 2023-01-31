//
//  CartView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import Foundation
import SwiftUI

//MARK: - 장바구니 View
/// 현재 로그인한 사용자의 장바구니를 보여주는 View
// TODO: - 삭제 액션 추가

struct CartView: View {
    
    // 각각의 항목을 선택하였는지, 전체 선택을 사용하여 선택하였는지를 판별하기 위한 변수
    @State var isAllSelected: Bool = false
    @State var allSelectButtonCheck : Bool = false
    
    var body: some View {
        VStack {
            
            // MARK: - View의 상단
            /// 전체선택, 선택삭제
            
            HStack {
                AllSelectButton
                Text("전체 선택")
                    .font(.bottles16)
                    .bold()
                Spacer()
                Button {
                    
                    // 선택 삭제 액션 추가
                    /// 품목 선택 후 선택삭제 버튼을 통한 삭제
                    
                } label: {
                    Text("선택 삭제")
                        .font(.bottles13)
                        .foregroundColor(.black)
                        .padding(.trailing)
                }
                
            }
            Divider()
                .background(.black)
            
            //MARK: - View의 중간
            /// 장바구니에 들어있는 품목 목록
            ScrollView {
                ForEach (0..<5) { cnt in
                    CartCell(isAllSelected: $isAllSelected, allSelectButtonCheck: $allSelectButtonCheck)
                    if cnt < 4 {
                        Divider()
                    }
                }
            }
            Divider()
                .background(.black)
            
            // MARK: - View의 하단
            // 총 금액, 예약하기 버튼
            VStack {
                HStack {
                    Text("총 금액")
                        .font(.bottles16)
                        .bold()
                        .padding(.leading)
                    Spacer()
                    Text("1,750,000원")
                        .font(.bottles16)
                        .bold()
                        .padding(.trailing)
                }
                .padding([.leading, .trailing, .top])
                Text("결제는 각 매장에서 진행됩니다.")
                    .font(.bottles13)
                    .padding(.top)
                
                NavigationLink(destination: ReservationPageView()) {
                    
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width : UIScreen.main.bounds.size.width-50, height: (UIScreen.main.bounds.size.width-50)/7)
                        .overlay(Text("예약하러 하기")
                            .foregroundColor(.white)
                            .font(.bottles18))
                            .bold()
                }
                .foregroundColor(.accentColor)
                .padding(.bottom, 20)
            }
            
        }
    }
    
    // MARK: - 전체 선택 버튼
    private var AllSelectButton : some View {
        Button {
            allSelectButtonCheck = true
            isAllSelected.toggle()
        } label : {
            Image(systemName: isAllSelected ? "checkmark.circle.fill" : "circle")
        }
        .padding([.leading, .top, .bottom])

    }
    
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
