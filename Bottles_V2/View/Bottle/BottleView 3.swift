//
//  BottleView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct BottleView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowingSheet: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    // 바틀 정보
                    BottleView_Info()
                    
                    // 바틀샵 리스트
                    VStack(alignment: .leading) {
                        Text("이 상품의 다른 바틀샵")
                            .font(.bottles15)
                            .fontWeight(.bold)
                            
                        ForEach(0..<3, id: \.self) {_ in
                            BottleView_ShopCell()
                        }
                    }
                    .padding()
                    
                    // 예약하기 버튼
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 51)
                            Text("예약하기")
                                .foregroundColor(.white)
                                .font(.bottles18)
                                .fontWeight(.bold)
                        }
                    }
                    .padding()
                }
            }
            if isShowingSheet {
                ReservationView(isShowing: $isShowingSheet)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar(content: {
            ToolbarItem (placement: .navigationBarLeading)  {
                Image("back")
                    .onTapGesture {
                        self.presentationMode.wrappedValue.dismiss()
                    }
            }
        })
    }
}

struct BottleView_Previews: PreviewProvider {
    static var previews: some View {
        BottleView()
    }
}
