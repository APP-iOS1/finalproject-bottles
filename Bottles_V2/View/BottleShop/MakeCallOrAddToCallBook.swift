//
//  AddToCallBook.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/13.
//

import SwiftUI
import Contacts
import UIKit

struct MakeCallOrAddToCallBook: View {
    
    @State private var isSuccess: Bool = false
    @State private var showCallAction: Bool = false
    
    var bottleShop: ShopModel
    
    var body: some View {
//                Button(action: {
//                    self.addPhoneNumber()
//        //            print(bottleShop.shopPhoneNumber)
//                }) {
//                    Image("Phone.fill")
//                        .resizable()
//                        .aspectRatio(contentMode: .fit)
//                        .frame(width: 15)
//                        .padding(.trailing, 5)
//                }
//                .alert(isPresented: $showCallAction) {
//                    Alert(title: Text(bottleShop.shopPhoneNumber), message: nil, primaryButton: .default(Text("바로 연결"), action: {
//                        self.makeCall()
//                    }), secondaryButton: .cancel(Text("닫기")))
//                }
        
        Button(action: {
            self.showCallAction = true
            print(bottleShop.shopPhoneNumber)
        }) {
            Image("Phone.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 15)
                .padding(.trailing, 5)
            
        }
        .alert(isPresented: $showCallAction) {
            Alert(title: Text("\(bottleShop.shopName) \n\(bottleShop.shopPhoneNumber)"), message: nil, primaryButton: .default(Text("전화 걸기"), action: {
                self.makeCall()
            }), secondaryButton: .default(Text("번호 저장"), action: {
                self.addPhoneNumber()
                self.showCallAction = false
            }))
        }
    }
    
    func addPhoneNumber() {
        let store = CNContactStore()
        let contact = CNMutableContact()
        contact.phoneNumbers = [CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: bottleShop.shopPhoneNumber))]
        let request = CNSaveRequest()
        request.add(contact, toContainerWithIdentifier: nil)
        do {
            try store.execute(request)
            isSuccess = true
            showCallAction = true
        } catch {
            isSuccess = false
            showCallAction = false
        }
    }
    
    func makeCall() {
        if let url = URL(string: "tel://\(bottleShop.shopPhoneNumber)"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
}


//struct AddToCallBook_Previews: PreviewProvider {
//    static var previews: some View {
//        AddToCallBookAndCall(phoneNumber: "111-222-333")
//    }
//}
