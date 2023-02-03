//
//  CustomAlertView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/03.
//

import SwiftUI

struct CustomAlertView: View {
    @Binding var isPresented: Bool
    
    let message: String
    let primaryButtonTitle: String
    
    let primaryAction: () -> Void
    
    let withCancelButton: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            
            Text("\(message)")
                .font(.bottles14)
                .padding(.leading)
                .frame(height:41)
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
        CustomAlertView(isPresented: .constant(true), message: "사용할 수 있는 이메일 입니다.", primaryButtonTitle: "확인", primaryAction: {}, withCancelButton: true)
    }
}
