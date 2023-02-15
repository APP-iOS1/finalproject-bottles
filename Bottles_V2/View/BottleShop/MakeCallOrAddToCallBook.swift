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
    @Binding var calling: Bool
    
    var bottleShop: ShopModel
    
    var body: some View {
        // MARK: - "전화기 image 눌렀을 때" custom alert (시뮬레이터 x, 실기기에서만 작동)
        if calling {
            ZStack{
                ZStack{
                    Color.black.opacity(0.2)
                }
                .ignoresSafeArea()
                .onTapGesture {
                    calling = false
                }
                
                VStack(alignment: .center){
                    
                    VStack{
                        Text(bottleShop.shopName)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Text(bottleShop.shopPhoneNumber)
                    }
                    .font(.bottles16)
                    .padding(.top, 15)
                    
                    Divider()
                    
                    // 1. 전화 걸기 버튼
                    Button(action: {
                        self.makeCall()
                    }, label: {
                        Text("전화 걸기")
                    })
                    
                    Divider()
                    
                    // 2. 번호 저장 버튼
                    Button(action: {
                        self.addPhoneNumber()
                        self.showCallAction = false
                    }, label: {
                        Text("번호 저장")
                    })
                    
                    Divider()
                    
                    // 3. 창 닫기 버튼
                    Button(action: {
                        calling = false
                    }, label: {
                        Text("취소")
                            .foregroundColor(.gray)
                        
                    })
                }
                .padding(.bottom, 10)
                .frame(width: 240)
                .fontWeight(.semibold)
                .background(Color.white)
                .cornerRadius(12)
                .font(.bottles14)
                
            }
        } // if calling 문 끝
    }
    
    // MARK: - calling 번호 저장 함수
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
    
    // MARK: - calling 전화 걸기 함수
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
