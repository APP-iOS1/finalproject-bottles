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
                        self.saveAddress()
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
    
    //    // MARK: - calling 번호 저장 함수
    //    func addPhoneNumber() {
    //        let store = CNContactStore()
    //        let contact = CNMutableContact()
    //        contact.phoneNumbers = [CNLabeledValue(label: CNLabelHome, value: CNPhoneNumber(stringValue: bottleShop.shopPhoneNumber))]
    //        let request = CNSaveRequest()
    //        request.add(contact, toContainerWithIdentifier: nil)
    //        do {
    //            try store.execute(request)
    //            isSuccess = true
    //            showCallAction = true
    //        } catch {
    //            isSuccess = false
    //            showCallAction = false
    //        }
    //    }
    
    
    // MARK: [전화번호 주소록에 데이터 저장 메소드]
    let store = CNContactStore() // 전화번호 주소록 접근 객체
    func saveAddress(){
        print("")
        print("===============================")
        print("[ViewController >> saveAddress() :: 전화번호 주소록에 데이터 저장 실시]")
        print("===============================")
        print("")
        
        // [퍼미션 권한 확인]
        self.store.requestAccess(for: .contacts) { (granted, error) in
            guard granted // MARK: [권한이 부여된 경우]
            else { // MARK: [권한이 부여되지 않은 경우]
                print("")
                print("===============================")
                print("[ViewController >> saveAddress() :: 전화번호 주소록 접근 권한 비활성 상태]")
                print("===============================")
                print("")
                
                // [메인 큐에서 비동기 방식 실행 : UI 동작 실시]
                DispatchQueue.main.async {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        if UIApplication.shared.canOpenURL(url) {
                            Task {
                                await UIApplication.shared.open(url)
                            }
                        }
                    }
                    
                    
                    
                    //                    let alert = UIAlertController(title: "알림", message: "전화번호부 접근 권한을 허용해주세요.", preferredStyle: .alert)
                    //                    let okBtn = UIAlertAction(title: "확인", style: .default) { (action) in
                    //                        alert.dismiss(animated: true, completion: nil)
                    //                        // [사용자 앱 설정창 이동 수행 실시]
                    //                        let settingsURL = NSURL(string: UIApplication.openSettingsURLString)! as URL
                    //                        UIApplication.shared.open(settingsURL, options: [:], completionHandler: nil)
                    //                    }
                    //                    let noBtn = UIAlertAction(title: "취소", style: .cancel) { (action) in
                    //                        // [팝업창 닫기]
                    //                        alert.dismiss(animated: true, completion: nil)
                    //                    }
                    //                    alert.addAction(okBtn)
                    //                    alert.addAction(noBtn)
                    ////                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            print("")
            print("===============================")
            print("[ViewController >> saveAddress() :: 전화번호 주소록 접근 권한 활성 상태]")
            print("===============================")
            print("")
            
            // [저장할 사용사 정보 매핑 실시]
            let contact:CNMutableContact = self.getUserContact()
            
            
            // [전화번호 저장 요청 객체 생성 실시 및 주소록에 추가]
            let request = CNSaveRequest()
            request.add(contact, toContainerWithIdentifier:nil)
            
            
            // [저장 수행 실시]
            try! self.store.execute(request)
            
            
            // [저장된 정보 확인]
            let name = contact.familyName + contact.givenName // [이름]
            let phone = contact.phoneNumbers[0].value.value(forKey: "digits") ?? "" // [전화번호]
            print("")
            print("===============================")
            print("[ViewController >> saveAddress() :: 전화번호 주소록 데이터 저장 완료]")
            print("name :: ", name)
            print("phone :: ", phone)
            print("===============================")
            print("")
        }
    }
    // [저장하려는 사용자 정보 매핑 수행]
    func getUserContact() -> CNMutableContact {
        
        // [주소록 객체 생성 실시]
        let contact = CNMutableContact()
        
        // [이름 지정 실시]
        contact.familyName = bottleShop.shopName
        contact.givenName = ""
        
        // [전화 번호 지정 실시]
        let phone = CNLabeledValue(label:CNLabelPhoneNumberMobile,
                                   value:CNPhoneNumber(stringValue: bottleShop.shopPhoneNumber))
        contact.phoneNumbers = [phone]
        
        // [매핑된 정보 리턴 실시]
        return contact
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
