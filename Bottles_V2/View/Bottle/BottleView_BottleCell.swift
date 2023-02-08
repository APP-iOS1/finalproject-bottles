//
//  BottleView_BottleCell.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/06.
//

import SwiftUI

// MARK: - 바틀 셀(바틀 이미지, 바틀 이름, 바틀 가격, 바틀샵 이름, 북마크)
struct BottleView_BottleCell: View {
    @EnvironmentObject var userStore: UserStore
    var bottleData: BottleModel
    @State private var checkBookmark: Bool = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            // MARK: - 바틀 이미지
            AsyncImage(url: URL(string: bottleData.itemImage)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            } placeholder: {
                Image("ready_image")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 128, height: 128)
                    .cornerRadius(12)
            }
            .background(Color.gray_f7)
            .padding(.bottom, 8)
            
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    // MARK: - 바틀 이름
                    Text(bottleData.itemName)
                        .font(.bottles14)
                        .fontWeight(.medium)
                    
                    // MARK: - 바틀 가격
                    Text("\(bottleData.itemPrice)원")
                        .font(.bottles18)
                        .fontWeight(.bold)
                
                    // MARK: - 바틀샵 이름
                    HStack {
                        Image("Map_tab_fill")
                            .resizable()
                            .frame(width: 14, height: 17)
                        // MARK: - 바틀샵 이름
                        Text(bottleData.shopName)
                            .font(.bottles14)
                            .fontWeight(.medium)
                    }
                }
                .foregroundColor(.black)
                
                Spacer()
                
                // MARK: - 북마크
                
                Button(action: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        checkBookmark.toggle()
                    }
                    print(bottleData.id)
                    if compareMyFollowBottleID(bottleData.id) == true {
                        checkBookmark = false
                        userStore.deleteFollowItemId(bottleData.id)
                    }

                    if compareMyFollowBottleID(bottleData.id) == false {
                        checkBookmark = true
                        userStore.addFollowItemId(bottleData.id)
                    }
                    
                }) {
                    Image(compareMyFollowBottleID(bottleData.id) ? "BookMark.fill" : "BookMark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 18)
                        .padding(.horizontal, 10)
                }
                
//                Button(action: {
//                    checkBookmark.toggle()
//                }) {
//                    Image(checkBookmark ? "bookmark_fill" : "bookmark")
//                        .resizable()
//                        .frame(width: 15, height: 18)
//                        .padding(.horizontal, 10)
//                }
            }
            .padding(.top, 10)
        }
    }
    
    func compareMyFollowBottleID(_ bottleId: String) -> Bool {
        return (userStore.user.followItemList.filter { $0 == bottleId }.count != 0) ? true : false
    }
}

//struct BottleView_BottleCell_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView_BottleCell()
//    }
//}
