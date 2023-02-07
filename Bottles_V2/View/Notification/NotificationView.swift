//
//  NotificationView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

//MARK: - 알림 View
/// 현재 로그인한 사용자의 알림을 보여주는 View

struct NotificationView: View {
    
    @State private var onlyReservation : Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    onlyReservationButton
                    Text("예약 알림만 보기")
                        .font(.bottles13)
                    Spacer()
                }
                Divider()
                    .background(.black)
                
                // MARK: - 알림 Cell
                // TODO: 네비게이션 링크 연결
                /// 예약내역, 새로운 소식,
                ScrollView {
                    NavigationLink(destination: PickUpListView()){
                        NotificationCell(title: "예약이 확정되었습니다.",
                        description: "칼호만 샤닉", time: "2시간 전")
                    }
                    Divider()
                        .background(.black)
                    
                    // BottleShopCurationView()로 변경해야 함
                    NavigationLink(destination: BottleView()){
                        NotificationCell(title: "저장한 바틀샵의 새로운 소식",
                        description: "새로운 큐레이션 타이틀", time: "4시간 전")
                    }

                    
                    Divider()
                        .background(.black)
                }
            }.navigationBarTitle("알림", displayMode: .inline)
        }
        
        
    }
    
    // MARK: - 예약알림만 보기 버튼
    private var onlyReservationButton : some View {
        Button {
            onlyReservation.toggle()
        } label : {
            Image(systemName: onlyReservation ? "checkmark.square.fill" : "square")
        }
        .padding([.leading, .top, .bottom])
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
