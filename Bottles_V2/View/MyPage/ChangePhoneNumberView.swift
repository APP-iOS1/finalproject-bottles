//
//  ChangePhoneNumberView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/02/14.
//

import SwiftUI

struct ChangePhoneNumberView: View {
    let phoneNumberExpression: String = "^01[0-1,7][0-9]{7,8}$"
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var phoneNumber: String = ""
    
    @State var isShowingAlert: Bool = false
    @EnvironmentObject var userStore: UserStore
    var body: some View {
        VStack {
            HStack{
                Text("변경할 휴대폰 번호")
                    .font(.bottles14)
                Spacer()
            }
            .padding(.horizontal, 20)
            TextField("변경하실 핸드폰 번호를 입력해주세요", text: $phoneNumber)
                .modifier(LoginTextFieldModifier(width: 357, height: 48))
                .keyboardType(.numberPad)
            Button(action: {
                isShowingAlert = true
            }){
                Text("변경하기")
                    .modifier(EmailViewButtonModifier(width: 357, height: 48))
            }
            .disabled(phoneNumberNotFitFormat)
        }
        .onTapGesture {
            endTextEditing()
        }
        .navigationBarTitle("휴대폰 번호 변경")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
        .customAlert(isPresented: $isShowingAlert, message: "입력하신 번호로 휴대폰 번호를 변경합니다.", primaryButtonTitle: "확인", primaryAction: {
            userStore.updateUserPhoneNumber(phoneNumber: phoneNumber)
            self.presentationMode.wrappedValue.dismiss()
        }, withCancelButton: true)
    }
    
    private var phoneNumberNotFitFormat: Bool {
        phoneNumber.range(of: phoneNumberExpression, options: .regularExpression) == nil
    }
    
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }
    }
}

struct ChangePhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePhoneNumberView().environmentObject(UserStore())
    }
}
