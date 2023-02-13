//
//  PickUpListView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpListView: View {
    
    @EnvironmentObject var reservationDataStore: ReservationDataStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack{
            ScrollView{
                // TODO: 예약 리스트 배열을 넣어 순회해줘야 함
                ForEach(reservationDataStore.reservationData) { reservationData in
                    NavigationLink(destination: PickUpDetailView()){
                        PickUpListCell(reservationData: reservationData)
                    }
                    Divider()

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
