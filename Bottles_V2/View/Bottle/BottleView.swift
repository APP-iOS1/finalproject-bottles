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
                    BottleView_Info()
                    VStack(alignment: .leading) {
                        Text("이 바틀샵의 다른 상품")
                            .font(.subheadline)
                            .fontWeight(.bold)
                            
                        ForEach(0..<3, id: \.self) {_ in
                            BottleView_ShopCell()
                        }
                    }
                    .padding()
                    
                    Button(action: {
                        isShowingSheet.toggle()
                    }) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 358, height: 51)
                            Text("예약하기")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold))
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
