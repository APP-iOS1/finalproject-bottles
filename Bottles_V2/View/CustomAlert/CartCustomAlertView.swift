//
//  CartCustomAlertView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/14.
//

import SwiftUI

struct CartCustomAlertView: View {
    /// CustomAlert을 띄워줄 trigger
    @Binding var isPresented: Bool
    
    /// CustomAlert Title
    let title: String
    
    /// CustomAlert 내용
    let message: String
    
    /// 동작시킬 버튼 이름 (ex: '확인')
    let primaryButtonTitle: String
    
    /// 동작시킬 버튼의 메소드
    let primaryAction: () -> Void
    
    /// 취소 버튼이 필요할 때 true 필요 없으면 false
    let withCancelButton: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("\(title)")
                .font(.bottles14)
                .fontWeight(.medium)
                .padding(.leading)
                .frame(height: 36)
                .multilineTextAlignment(.leading)
            
            Text("\(message)")
                .font(.bottles12)
                .fontWeight(.regular)
                .padding(.leading)
                .frame(height: 36)
                .lineLimit(2)
                .multilineTextAlignment(.leading)
            HStack {
                if withCancelButton {
                    Spacer()
                    
                    Button(action:{
                        isPresented = false
                    }) {
                        Text("취소")
                            .font(.bottles14)
                            .fontWeight(.medium)
                            .foregroundColor(Color.purple_2)
                    }
                }
                
                Spacer()
                Spacer()
                
                Button(action:{
                    primaryAction()
                    isPresented = false
                }){
                    Text("\(primaryButtonTitle)")
                        .font(.bottles14)
                        .fontWeight(.medium)
                        .foregroundColor(Color("AccentColor"))
                }
                
                Spacer()
            }
            .padding(.top, 5)
            .padding(.trailing, 10)
        }
        .padding(10)
        .frame(width: 310, height: 164)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(.primary)
                .colorInvert()
        }
    }
}

struct CartCustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CartCustomAlertView(isPresented: .constant(true), title: "장바구니에는 같은 바틀샵의 상품만 담을 수 있습니다.", message: "선택하신 상품을 장바구니에 담을 경우 이전에 담은 상품이 삭제됩니다.", primaryButtonTitle: "확인", primaryAction: {}, withCancelButton: true)
    }
}

