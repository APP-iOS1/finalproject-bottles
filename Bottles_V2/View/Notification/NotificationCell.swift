//
//  NotificationCell.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/18.
//

import SwiftUI

struct NotificationCell: View {
    //테스트용 텍스트
    var title : String = "test"
    var subTitle : String = "test"
    var time : String = "test"
    
    var body: some View {
        HStack {
            Spacer()
            // 이미지 자리
            Circle()
                .frame(width: UIScreen.main.bounds.size.width/7, height: UIScreen.main.bounds.size.width/7)
                .padding([.leading, .trailing])
            
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text(title)
                        .font(.subheadline)
                        .bold()
                    Spacer()
                    Text(time)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                Text(subTitle)
                    .font(.footnote)
                HStack {
                    Image("MapMarker")
                        .resizable()
                        .frame(width: 12, height: 17)
                    Text("바틀샵 이름")
                        .font(.subheadline)
                }

            }
           
        }
        .frame(height:UIScreen.main.bounds.size.width/4)

    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
