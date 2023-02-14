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
        "https://www.apple.com/kr/", //바틀스 소개링크 링크
        "https://www.google.com/", // 공지사항 링크
        "https://www.naver.com/", // 자주 묻는 질문 링크
        "https://github.com/", // 1:1 문의하기 링크
        "https://developer.apple.com/", // 서비스 이용약관 링크
        "https://portal.korea.ac.kr/front/Intro.kpd", // 개인정보 처리방침 링크
        "https://console.firebase.google.com/", // 위치정보 이용약관 링크
        "https://techit.education/" // 버전정보 링크
    ]
    @State private var isShowingSheet: Bool = false
    
    /// SafariWebView에 바인딩으로 링크 자체를 넘겨준다.
    @State var selectedUrl: URL = URL(string: "https://www.naver.com")!
    
    @Binding var selection: Int
    var body: some View {
        NavigationStack {
            VStack {
                //MARK: - 프로필 HStack
                HStack {
                    
                    // TODO: 프로필 이미지 들어갈 곳
                    Image("profile")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width/7, height: UIScreen.main.bounds.width/7)
                    
                    // TODO: 닉네임 들어갈 곳
                    Text("\(userStore.user.nickname) 님")
                        .font(.bottles18)

                    Spacer()
                    NavigationLink(destination: SettingView(selection: $selection)){
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
                            .foregroundColor(.accentColor)
                    }
                }
                .listStyle(.plain)
                .scrollDisabled(true)
                .frame(height: 40)
                
                Divider()

                
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
        .navigationBarTitle("MY", displayMode: .inline)
        
    }
    

}


struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView(selection: .constant(1))
    }
}
