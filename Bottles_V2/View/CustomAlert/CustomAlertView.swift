//
//  CustomAlertView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/03.
//

import SwiftUI

struct CustomAlertView: View {
    /// CustomAlert을 띄워줄 trigger
    @Binding var isPresented: Bool
    
    /// CustomAlert 내용
    let message: String
    
    /// 동작시킬 버튼 이름 (ex: '확인')
    let primaryButtonTitle: String
    
    /// 동작시킬 버튼의 메소드
    let primaryAction: () -> Void
    
    /// 취소 버튼이 필요할 때 true 필요 없으면 false
    let withCancelButton: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(message)")
                .font(.bottles14)
                .padding(.leading)
                .frame(height: 41)
                .multilineTextAlignment(.leading)
            HStack{
                Spacer()
                Button(action:{
                    primaryAction()
                    isPresented = false
                }){
                    Text("\(primaryButtonTitle)")
                        .font(.bottles14)
                }
                if withCancelButton {
                    Button(action:{
                        isPresented = false
                    }) {
                        Text("취소")
                            .font(.bottles14)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(.top, 5)
            .padding(.trailing, 10)
//            .padding(.bottom, 0)
        }
        .padding(10)
        .frame(width: 310, height: 110)
        .background{
            RoundedRectangle(cornerRadius: 12)
                .fill(.primary)
                .colorInvert()
        }
    }
}

struct CustomAlertView_Previews: PreviewProvider {
    static var previews: some View {
        CustomAlertView(isPresented: .constant(true), message: "가입한 이메일의 인증 메일을 확인하면 회원 가입이 완료 됩니다.", primaryButtonTitle: "확인", primaryAction: {}, withCancelButton: true)
    }
}
