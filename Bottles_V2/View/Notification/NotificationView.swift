//
//  NotificationView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

//MARK: - 알림 View
/// 현재 로그인한 사용자의 알림을 보여주는 View

//protocol ViewModel: Identifiable<String> {}
//
//struct AnyViewModel: Identifiable {
//    var base: any ViewModel
//    var id: String { base.id }
//}

protocol TestProtocol: Identifiable, Hashable {
    var classification: String { get set }
    var id: String { get set }
    
    // 예약 현황
    var shopId : String { get set }
    var userId : String { get set }    // 이메일 형식으로 들어옴
    var reservedTime : Date { get set }
    var state : String { get set }
    
    // 샵 노티스 공지 사항
    var category : String { get set }
    var shopName : String { get set }
    var date : Date { get set }
    var title : String { get set }
    var body: String { get set }
    
    static func == (lhs: Self, rhs: Self) -> Bool
}

extension TestProtocol {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
    
    func calculateTime(_ date: Date) -> String {
        let format = DateFormatter()
        format.locale = Locale(identifier: "ko_KR")
        format.dateFormat = "M월 d일"
        return getTimeName(Int(Date().timeIntervalSince(date)), format.string(from: date))
    }
    
    func getTimeName(_ time: Int, _ date: String) -> String {
        let result = time / 60
        switch result {
        case 0:
            return "방금"
        case 1 ... 59:
            return "\(result)분 전"
        case 60 ... 1439:
            return "\(result / 60)시간 전"
        default:
            return date
        }
    }
}

struct Container: Identifiable, Hashable{
    //implement the same equality as in your TestProtocol
    static func == (lhs: Container, rhs: Container) -> Bool {
        rhs.wrapped.id == lhs.wrapped.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(wrapped)
    }
    
    var wrapped: any TestProtocol
    //for convenience
    var classification: String { wrapped.classification }
    var id: String {wrapped.id}
    var shopId: String {wrapped.shopId}
    var userId: String {wrapped.userId}
    var reservedTime: Date {wrapped.reservedTime}
    var state: String {wrapped.state}
    
    var category : String { wrapped.category }
    var shopName : String { wrapped.shopName }
    var date : Date { wrapped.date }
    var title : String { wrapped.title }
    var body: String { wrapped.body }
}

struct NotificationView: View {
    @EnvironmentObject var userStore: UserStore
    @State private var onlyReservation : Bool = false
    @EnvironmentObject var shopNoticeDataStore : ShopNoticeDataStore
    @EnvironmentObject var reservationDataStore : ReservationDataStore
    @State private var mappingData: [Any] = []
    
    @State private var selected: (any TestProtocol)?
    
    func filteredMyNotice() -> [ShopNotice] {
        var resultData: [ShopNotice] = []
        for item in userStore.user.noticeList {
            print("내 노티스 리스트 \(item)")
            let filteredData = shopNoticeDataStore.shopNoticeData.filter {$0.id == item }
           
            resultData.append(contentsOf: filteredData)
            resultData.sort { $0.date > $1.date }
        }
        return resultData
    }
    
    func filteredMyReservation() -> [ReservationModel] {
        var resultData: [ReservationModel] = []
        for item in userStore.user.pickupItemList {
            print("내 예약 리스트 \(item)")
            let filteredData = reservationDataStore.reservationData.filter {$0.id == item }
           
            resultData.append(contentsOf: filteredData)
            resultData.sort { $0.reservedTime > $1.reservedTime }
        }
        return resultData
    }
    
    func mappingMyInfo() -> [any TestProtocol] {
        let myNoticeData = filteredMyNotice()
        let myReservationData = filteredMyReservation()
        var resultData: [any TestProtocol] = myNoticeData + myReservationData
        self.mappingData = resultData
//        resultData.sort { $0.date > $1.reservedTime }
        return resultData
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
                    ForEach(mappingMyInfo(), id: \.id) { item in
//                        if item.classification == "예약" {
                        NavigationLink {
                            PickUpListView()
                        } label: {
                            if item.classification == "공지사항" {
                                NotificationCell(imgName: "shopNotification", title: item.title, description: item.body, storeName: item.shopName, time: "\(item.calculateTime(item.date))")
                            } else {
                                NotificationCell(imgName: "checkNotification", title: "예약 현황: \(item.state)", description: "test", storeName: item.shopId, time: "\(item.calculateTime(item.reservedTime))")
                            }
//
                        }
//
//                        if item.classification == "공지" || item.classification == "이벤트" {
//                            NavigationLink {
//                                PickUpListView()
//                            } label: {
//                                NotificationCell(imgName: "shopNotification", title: item.title, description: item.body, storeName: item.shopName, time: "\(item.calculateTime())")
//                            }
//                        }
                        
//                        if item.category != "공지" || item.category != "이벤트" {
//                            NavigationLink(destination: PickUpListView()){
//                                NotificationCell(imgName: "checkNotification", title: "예약이 확정되었습니다.", description: "샤도네이 2017", storeName: "와인앤모어 군자점", time: "2시간 전")
//                            }
//                        } else {
//                            NavigationLink {
////                                PickUpListView()
//                            } label: {
//                                NotificationCell(imgName: "shopNotification", title: item.title, description: item.body, storeName: item.shopName, time: "\(item.calculateTime())")
//                            }
//                        }
                        
                        
                        
                    }
                    
                    //                    NavigationLink(destination: PickUpListView()){
                    //                        NotificationCell(imgName: "checkNotification", title: "예약이 확정되었습니다.", description: "샤도네이 2017", storeName: "와인앤모어 군자점", time: "2시간 전")
                    //
                    //                    }
                }
            }
            .task {
                
//                mappingMyInfo()
//                shopNoticeDataStore.getAllShopNoticeDataRealTime()
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

//struct NotificationView_Previews: PreviewProvider {
//    static var previews: some View {
//        NotificationView()
//    }
//}
