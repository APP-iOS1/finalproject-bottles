//
//  NotificationCell.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/18.
//

import SwiftUI

// MARK: - 알림 Cell
/// 알림 리스트의 셀

struct NotificationCell: View {
    //테스트용 텍스트
    var title : String = "test"
    var description : String = "test"
    var time : String = "test"
    
    var body: some View {
        HStack {
            Spacer()
            // MARK: - 이미지
            AsyncImage(url: URL(string: ""))
                .frame(width: UIScreen.main.bounds.size.width/7, height: UIScreen.main.bounds.size.width/7)
                .clipShape(Circle())
                .padding([.leading, .trailing])
            
            // MARK: - 가운데 텍스트(공지타이틀, 내용, 바틀샵 이름)
            VStack(alignment: .leading, spacing: 7) {
                HStack {
                    // 공지 타이틀
                    Text(title)
                        .font(.bottles15)
                        .foregroundColor(.black)
                        .bold()
                    Spacer()
                    
                    // 알림이 온 지 얼마나 지났는지
                    Text(time)
                        .font(.bottles13)
                        .foregroundColor(.gray)
                        .padding(.trailing)
                }
                
                // 알림 내용
                Text(description)
                    .font(.bottles13)
                    .foregroundColor(.black)
                
                // 알림이 온 바틀샵의 이름
                HStack {
                    Image("MapMarker")
                        .resizable()
                        .frame(width: 12, height: 17)
                    Text("바틀샵 이름")
                        .foregroundColor(.black)
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
