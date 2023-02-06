//
//  ReservedView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 예약 완료
struct ReservedView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowing: Bool = true
    
    var body: some View {
        NavigationStack {
            // TODO: - 루트뷰로 이동해야함
            Button(action: {}) {
                Image(systemName: "xmark")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .foregroundColor(.black)
                    .padding()
            }

            Spacer()
            
            VStack {
                Image("check")
                    .resizable()
                    .frame(width: 162.5, height: 162.5)
                
                Text("예약이 완료되었습니다.\n곧 예약 확정 알림을 보내드릴게요!")
                    .font(.bottles18)
                    .fontWeight(.bold)
                    .foregroundColor(Color("AccentColor"))
                    .multilineTextAlignment(.center)
                    .lineSpacing(5)
                    .padding()
            }
            .offset(y: -85)
            
            Spacer()
       
            // MARK: - 예약 확인 버튼
            NavigationLink(destination: PickUpDetailView()) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 358, height: 56)
                    Text("예약 확인하기")
                        .modifier(AccentColorButtonModifier())
                }
            }
            .padding(.bottom)
        }
        .sheet(isPresented: $isShowing) {
            ReservedView_BottleShop()
                .presentationDetents([.height(210)])
        }
        .navigationBarBackButtonHidden(true)
    }
}

struct ReservedView_Previews: PreviewProvider {
    static var previews: some View {
        ReservedView()
    }
}
