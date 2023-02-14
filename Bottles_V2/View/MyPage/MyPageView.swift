//
//  MyPageView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI


struct MyPageView: View {
    
    @EnvironmentObject var userStore: UserStore
    var myPageList: [String] = ["바틀스 소개", "공지사항", "자주 묻는 질문",
                                "1:1 문의하기", "서비스 이용약관", "개인정보 처리방침", "위치정보 이용약관", "버전 정보"]
    
    var myPageListWebLink: [String] = [
        "https://wheat-freedom-6f8.notion.site/Bottles-ed9da0c0329241baab298888c379c5c5", //바틀스 소개링크
        "https://meadow-vinca-bdb.notion.site/Bottles-fb02726a48a64794a9d4a525928ef88a", // 공지사항 링크
        "https://www.notion.so/Bottles-7ebcada52db04721be6234012fa74fa9", // 자주 묻는 질문 링크
        "http://pf.kakao.com/_acUxexj/chat", // 1:1 문의하기 링크
        "https://buttercup-blue-7c3.notion.site/Bottles-2e87d483ef024a13941c31d6ddeccd1f", // 서비스 이용약관 링크
        "https://buttercup-blue-7c3.notion.site/Bottles-7a8ac8ff1a5141ddb73f7eb808689f48", // 개인정보 처리방침 링크
        "https://buttercup-blue-7c3.notion.site/Bottles-5301836bf4c046419ee6379dd261be37", // 위치정보 이용약관 링크
        "https://www.notion.so/Bottles-9e25937e44f643848a721229fd4dc295" // 버전정보 링크
    ]
    @State private var isShowingSheet: Bool = false
    
    /// SafariWebView에 바인딩으로 링크 자체를 넘겨준다.
    @State var selectedUrl: URL = URL(string: "https://www.naver.com")!
    
    var body: some View {
        NavigationStack {
            VStack {
                //MARK: - 프로필 HStack
                HStack {
                    
                    // TODO: 프로필 이미지 들어갈 곳
                    Circle()
                        .frame(width: 65, height: 65)
                    
                    // TODO: 닉네임 들어갈 곳
                    Text(userStore.user.nickname)
                        .font(.bottles18)
                        .bold()
                    Spacer()
                    NavigationLink(destination: SettingView()){
                        Image(systemName: "gearshape.fill")
                        //                            .foregroundColor(.accentColor)
                            .font(.title2)
                    }
                }
                .padding()
                
                //MARK: - 예약 내역
                List{
                    NavigationLink(destination: PickUpListView()){
                        Text("예약 내역")
                            .font(.bottles15)
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(height: 40)
                
                Rectangle()
                    .frame(height: 7)
                    .foregroundColor(Color("lightGray"))
                
                // MARK: - 두번째 리스트 ( 바틀스 소개, 공지사항, 자주묻는 질문...)
                
                List {
                    ForEach(0..<myPageList.count, id: \.self) { index in
                        
                        Button(action: {
                            // 버튼 액션에서 selectedUrl에 지금 누른 버튼 링크 값을 넣어줌
                            selectedUrl = URL(string: myPageListWebLink[index])!
                            isShowingSheet.toggle()
                            
                        }){
                            Text("\(myPageList[index])") // 리스트 이름
                                .font(.bottles15)
                        }
                        .sheet(isPresented: $isShowingSheet, content: {
                            SafariWebView(selectedUrl: $selectedUrl)
                        })
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
