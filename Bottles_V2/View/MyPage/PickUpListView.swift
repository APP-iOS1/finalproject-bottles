//
//  PickUpListView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpListView: View {
    
    @EnvironmentObject var reservationDataStore: ReservationDataStore
    @EnvironmentObject var userStore: UserStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    func filterAndSortReservationData() -> [ReservationModel] {
        let filiteredData = reservationDataStore.reservationData.filter {
            $0.userID == userStore.user.email
        }
        let sortedData = filiteredData.sorted(by: {$0.reservedTime > $1.reservedTime})
        return sortedData
    }
    var body: some View {
        VStack{
            if filterAndSortReservationData().isEmpty {
                VStack{
                    Spacer()
                    Image(systemName: "calendar")
                        .font(.system(size: 60))
                    Spacer()
                        .frame(height: 20)
                    
                    Text("예약 내역이 없습니다.")
                        .font(.bottles20)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .foregroundColor(.gray)
                .padding(.top, -100)
            } else {
                ScrollView{
                    // TODO: 예약 리스트 배열을 넣어 순회해줘야 함
                    ForEach(filterAndSortReservationData()) { reservationData in
                        NavigationLink(destination: PickUpDetailView(reservationData: reservationData)){
                            PickUpListCell(reservationData: reservationData)
                        }
                        Divider()
                      
                    }
                }
            }
        }
        .navigationTitle("예약 내역")
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }
    }

}

struct PickUpListView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpListView()
    }
}
