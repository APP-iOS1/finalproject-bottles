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
    @EnvironmentObject var userStore: UserStore
    @State private var onlyReservation : Bool = false
    @EnvironmentObject var shopNoticeDataStore : ShopNoticeDataStore
    
    func filteredMyFollowShop() -> [ShopNotice] {
        var shopNotice: [ShopNotice] = []
        for followShopId in userStore.user.followShopList {
            print(userStore.user.followShopList)
            let filtered = shopNoticeDataStore.shopNoticeData.filter { $0.shopName == followShopId }
            shopNotice.append(contentsOf: filtered)
            shopNotice.sort { $0.date > $1.date }
        }
        return shopNotice
    }
    
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
                
                // MARK: - 알림 Cell
                /// 예약내역, 새로운 소식,
                ScrollView {
                    ForEach(filteredMyFollowShop()) { item in
                        NavigationLink {
                            PickUpListView()
                        } label: {
                            NotificationCell(imgName: "shopNotification", title: item.title, description: item.body, storeName: item.shopName, time: "\(item.calculateTime())")
                        }
                        
                    }
                    
                    //                    NavigationLink(destination: PickUpListView()){
                    //                        NotificationCell(imgName: "checkNotification", title: "예약이 확정되었습니다.", description: "샤도네이 2017", storeName: "와인앤모어 군자점", time: "2시간 전")
                    //
                    //                    }
                }
            }
            .navigationBarTitle("알림", displayMode: .inline)
        }
    }
    
    // MARK: - 예약알림만 보기 버튼
    private var onlyReservationButton : some View {
        Button {
            onlyReservation.toggle()
        } label : {
            if onlyReservation {
                Image(systemName: "checkmark.circle")
                    .foregroundColor(.accentColor)
            }
            else {
                Image(systemName: "circle")
                    .foregroundColor(.gray)
            }
            
        }
        .padding([.leading, .top, .bottom])
    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}
