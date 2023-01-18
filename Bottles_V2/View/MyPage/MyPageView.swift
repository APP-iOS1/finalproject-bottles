//
//  MyPageView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI

struct MyPageView: View {
    
    var myPageList: [String] = ["바틀스 소개", "공지사항", "자주 묻는 질문", "1:1 문의하기", "서비스 이용약관", "개인정보 처리방침", "위치정보 이용약관", "버전 정보"]
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Circle()
                        .frame(width: 65, height: 65)
                    Text("밤삭님")
                    Spacer()
                    NavigationLink(destination: SettingView()){
                        Image(systemName: "gearshape.fill")
                            .font(.title2)
                    }
                }
                .padding()
                List{
                    NavigationLink(destination: PickUpListView()){
                        Text("예약 내역")
                            .bold()
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(height: 40)
                
                Rectangle()
                    .frame(height: 7)
                    .foregroundColor(.gray)
                List {
                    ForEach(myPageList, id: \.self) { item in
                        NavigationLink(destination: Text("\(item)")){
                            Text("\(item)")
                                .bold()
                        }
                        .listRowSeparator(.hidden)
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                
            }
        }
    }
}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
