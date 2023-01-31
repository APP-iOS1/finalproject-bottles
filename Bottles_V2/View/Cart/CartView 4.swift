//
//  CartView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import Foundation
import SwiftUI

struct CartView: View {
    @State var isAllSelected: Bool = false
    @State var allSelectButtonCheck : Bool = false
    
    var body: some View {
        VStack {
            //MARK: - 상단 전체선택, 선택삭제
            HStack {
                AllSelectButton
                Text("전체 선택")
                    .font(.bottles16)
                    .bold()
                Spacer()
                Text("선택 삭제")
                    .font(.bottles13)
                    .padding(.trailing)
            }
            Divider()
                .background(.black)
            //MARK: - 장바구니 품목 셀
            ScrollView {
                ForEach (0..<5) { cnt in
                    CartCell(isAllSelected: $isAllSelected, allSelectButtonCheck: $allSelectButtonCheck)
                    if cnt < 4 {
                        Divider()
//                            .background(.black)
                    }
                }
            }
            Divider()
                .background(.black)
            
            // MARK: - 총 금액, 예약하기 버튼
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
                Button {
                    //예약하기 액션
                } label: {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width : UIScreen.main.bounds.size.width-50, height: (UIScreen.main.bounds.size.width-50)/7)
                        .overlay(Text("예약하기")
                            .foregroundColor(.white)
                            .font(.bottles18))
                            .bold()
                }
                .padding(.bottom, 20)
               
            }
            
        }
    }
    
    // MARK: - 전체 선택
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
