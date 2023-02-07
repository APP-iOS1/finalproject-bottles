//
//  SentEmailView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/06.
//

import SwiftUI

struct SentEmailView: View {
    var email: String
    var body: some View {
        VStack(alignment:.center){
            Image("Mail")
                .resizable()
                .frame(width: 40, height: 31.43)
                .padding(.bottom, 10)
            VStack{
                Text("\(email)")
                    .foregroundColor(.accentColor)
                + Text("으로")
                Text("비밀번호 재설정 메일이 발송 되었어요.")
            }
            .font(.bottles16)
        }
    }
}

struct SentEmailView_Previews: PreviewProvider {
    static var previews: some View {
        SentEmailView(email: "test@test.com")
    }
}
