//
//  ReservedView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

// MARK: - 예약 완료
struct ReservedView: View {
    //@EnvironmentObject var path: Path
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State private var isShowing: Bool = true
    @State private var isShowingBookmarkView: Bool = false
    @State private var isShowingFillBookmarkMessage: Bool = false
    @State private var isShowingEmptyBookmarkMessage: Bool = false
    var reservationData: ReservationModel
    
    var body: some View {
        NavigationStack {
            // TODO: - 루트뷰로 이동해야함
            Button(action: {
                //print(path.path)
                //path.path = NavigationPath()
                UIView.setAnimationsEnabled(false) 
                isShowingBookmarkView.toggle()
            }) {
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
            .offset(y: -80)
            
            Spacer()
       
            // MARK: - 예약 확인 버튼
            NavigationLink(destination: PickUpDetailView(reservationData: reservationData)) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .frame(width: 358, height: 56)
                    Text("예약 확인하기")
                        .modifier(AccentColorButtonModifier())
                }
            }
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $isShowing) {
            ReservedView_BottleShop(
                isShowingFillBookmarkMessage: $isShowingFillBookmarkMessage,
                isShowingEmptyBookmarkMessage: $isShowingEmptyBookmarkMessage
            )
                .presentationDetents([.height(210)])
                .presentationDragIndicator(.visible)
        }
//        .fullScreenCover(isPresented: $isShowingBookmarkView, content: {
//            MainTabView()
//                .accentColor(Color("AccentColor"))
//        })
      
        .navigationBarBackButtonHidden(true)
        .toolbar(.visible, for: .tabBar)
    }
}

class Path: ObservableObject {
    @Published var path: NavigationPath = NavigationPath()
}

//struct ReservedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservedView()
//    }
//}
