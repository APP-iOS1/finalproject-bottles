//
//  MyPageView.swift
//  Bottles_V2
//
//  Created by 강창현 on 2023/01/18.
//

import SwiftUI


struct MyPageView: View {
    
    var myPageList: [String] = ["바틀스 소개", "공지사항", "자주 묻는 질문",
                                "1:1 문의하기", "서비스 이용약관", "개인정보 처리방침", "위치정보 이용약관", "버전 정보"]
    
    var myPageListWebLink: [String] = [
        "https://www.apple.com/kr/", //바틀스 소개링크
        "https://www.google.com/",
        "https://www.naver.com/",
        "https://github.com/",
        "https://developer.apple.com/",
        "https://portal.korea.ac.kr/front/Intro.kpd",
        "https://console.firebase.google.com/",
        "https://techit.education/"
    ]
    
    @State private var isShowingSheet: Bool = false
    
    
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
                    Text("밤삭님")
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
                
                // MARK: - 두번째 리스트
                
                //                List {
                //                    ForEach(Array(myPageList.enumerated()), id: \.1) { (index, item) in
                //
                //                        //                        NavigationLink(destination: Webview(url: URL(string: myPageListWebLink[index])!)) {
                //                        //                            Text("\(item)")
                //                        //                        }
                //
                //                        Button(action: {
                //
                //                            isShowingSheet.toggle()
                //
                //                            //                            print("\(myPageListWebLink[index])")
                //                        }){
                //                            Text("\(item)")
                //                                .font(.bottles15)
                //                        }
                //                        .sheet(isPresented: $isShowingSheet, content: {
                //                            SafariWebView(url: URL(string: myPageListWebLink[index])!)
                //                        })
                //                        .listRowSeparator(.hidden)
                //                    }
                //                }
                //                .listStyle(.plain)
                //                .scrollDisabled(true)
                
                List {
                    ForEach(0..<myPageList.count, id: \.self) { index in
                        
                        Button(action: {
                            
                            selectedUrl = URL(string: myPageListWebLink[index])!
                            isShowingSheet.toggle()
                            
                        }){
                            Text("\(myPageList[index])")
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


//struct WebSheetView: View {
//    var index: Int
//    var webLinks: [String]
//    
//    var body: some View {
//        SafariWebView(url: URL(string: $webLinks[index])!)
//    }
//}

struct MyPageView_Previews: PreviewProvider {
    static var previews: some View {
        MyPageView()
    }
}
