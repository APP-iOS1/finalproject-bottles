//
//  PickUpDetailCell.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/02/14.
//

import SwiftUI

struct PickUpDetailCell: View {

    var bottleModel: BottleModel
    var count: Int
    
    var body: some View {
        // MARK: - 예약 세부 상품 HStack
//        HStack (alignment: .top){
//
//            // TODO: 예약 상품에 대한 이미지
//            AsyncImage(url: URL(string: bottleModel.itemImage)) { image in
//                image
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .frame(width: 125, height: 125)
//
//            } placeholder: {
//                Image("ready_image")
//                    .resizable()
//                    .scaledToFit()
//                    .frame(width: 125, height: 125)
//            }
//            .background(Color.gray_f7)
//            .cornerRadius(12)
//            .frame(height: 130)
//
//            VStack(alignment: .leading){
//                Text("\(bottleModel.itemName)")
//                    .font(.bottles14)
//                    .bold()
//                Text("\(bottleModel.itemPrice * count)원")
//                    .font(.bottles18)
//                    .padding(.vertical, -5)
//                    .bold()
//                Text("개당 \(bottleModel.itemPrice)원")
//                    .font(.bottles12)
//                    .foregroundColor(.gray)
//                    .padding(3)
//                Text("\(count)개")
//                    .font(.bottles14)
//            }
//            .padding(.top)
//            Spacer()
//        }
        
        HStack(alignment: .top, spacing: 8) {
            // MARK: - 상품 이미지
            AsyncImage(url: URL(string: bottleModel.itemImage)) { image in
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
            .cornerRadius(12)
            .frame(height: 128)
            
            VStack(alignment: .leading, spacing: 9) {
                // MARK: - 상품 이름
                Text(bottleModel.itemName)
                    .font(.bottles14)
                    .fontWeight(.medium)
                    
                // MARK: - 상품 가격
                Text("\(bottleModel.itemPrice * count)원")
                    .font(.bottles18)
                    .fontWeight(.bold)
                
                // MARK: - 개당 가격
                Text("개당 \(bottleModel.itemPrice)원")
                    .font(.bottles12)
                    .foregroundColor(.gray)
                    .padding(3)
                
                // MARK: - 상품 개수
                Text("\(count)개")
                    .font(.bottles15)
                    .fontWeight(.medium)
            }
            .padding(16)
        }
        .frame(height: 129)
        
    }
    
    
}

//struct PickUpDetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PickUpDetailCell()
//    }
//}
