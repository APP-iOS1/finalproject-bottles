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
            // MARK: - 이미지
            Circle()
                .frame(width: UIScreen.main.bounds.size.width/7, height: UIScreen.main.bounds.size.width/7)
                .padding([.leading, .trailing])
            
            // MARK: - 가운데 텍스트(공지타이틀, 서브 타이틀, 바틀샵 이름)
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    Text(title)
                        .font(.bottles15)
                        .bold()
                        .bold()
                    Spacer()
                    Text(time)
                        .font(.bottles13)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                Text(subTitle)
                    .font(.bottles13)
                HStack {
                    Image("MapMarker")
                        .resizable()
                        .frame(width: 12, height: 17)
                    Text("바틀샵 이름")
                        .font(.bottles15)
                }

            }
           
        }
        .frame(height:UIScreen.main.bounds.size.width/4.5)

    }
}

struct NotificationCell_Previews: PreviewProvider {
    static var previews: some View {
        NotificationCell()
    }
}
