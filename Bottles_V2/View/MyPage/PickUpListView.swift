//
//  PickUpListView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpListView: View {
    var body: some View {
        VStack{
            ScrollView{
                ForEach(1..<4, id:\.self){ _ in
                    NavigationLink(destination: PickUpDetailView()){
                        PickUpListCell()
                    }
                    Rectangle()
                        .frame(height: 7)
                        .foregroundColor(.gray)
                        .padding(.bottom, -6)
                }
            }
        }
        .navigationTitle("예약 내역")
    }
}

struct PickUpListView_Previews: PreviewProvider {
    static var previews: some View {
        PickUpListView()
    }
}
