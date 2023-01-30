//
//  NotificationView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct NotificationView: View {
    
    @State private var onlyReservation : Bool = false
    
    var body: some View {
        VStack {
            HStack {
                onlyReservationButton
                Text("예약 알림만 보기")
                Spacer()
            }
            Divider()
                .background(.black)
            ScrollView {
                NotificationCell(title: "예약이 확정되었습니다.",
                subTitle: "칼호만 샤닉", time: "2시간 전")
                Divider()
                    .background(.black)
                NotificationCell(title: "저장한 바틀샵의 새로운 소식",
                subTitle: "새로운 큐레이션 타이틀", time: "4시간 전")
                Divider()
                    .background(.black)
            }
        }
    }
    
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
