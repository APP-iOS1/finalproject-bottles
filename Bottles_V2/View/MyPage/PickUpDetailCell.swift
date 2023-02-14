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
        HStack (alignment: .top){
            
            // TODO: 예약 상품에 대한 이미지
            AsyncImage(url: URL(string: "https://d1e2y5wc27crnp.cloudfront.net/media/core/product/thumbnail/e8e8b60a-770c-4f67-ba67-ee3300ce0a5d.webp")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 130, height: 130)
                
            } placeholder: {
                Image("ready_image")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
            }
            .background(Color.gray_f7)
            .cornerRadius(12)
            .frame(height: 130)

            VStack(alignment: .leading){
                Text("디 오리지널 골드바 위스키")
                    .font(.bottles14)
                    .bold()
                Text("109,000원")
                    .font(.bottles18)
                    .padding(.vertical, 1)
                    .bold()
                Text("\(count)개")
                    .font(.bottles14)
            }
            Spacer()
        }
    }
    
    
}

//struct PickUpDetailCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PickUpDetailCell()
//    }
//}
