//
//  SettingView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct SettingView: View {
    var settingViewList: [String] = ["휴대폰 번호 변경", "알림 설정"]
    // 로그아웃 Alert
    @State private var logoutAlert: Bool = false
    // 회원 탈퇴 Alert
    @State private var unregisterAlert: Bool = false
    var body: some View {
        VStack {
            List {
                ForEach(settingViewList, id: \.self) { item in
                    NavigationLink(destination: Text("\(item)")) {
                        Text("\(item)")
                    }
                    .listRowSeparator(.hidden)
                }
            }
            .listStyle(.plain)
            .frame(height: 80)
            .scrollDisabled(true)
            .padding(.top)
            
            HStack {
                Spacer()
                Button(action:{
                    logoutAlert.toggle()
                }){
                    Text("로그아웃")
                        .font(.footnote)
                }
                .padding(.horizontal)
                .alert(isPresented: $logoutAlert) {
                    Alert(title: Text("로그아웃 하시겠습니까?"),
                          message:
                            Text("로그아웃하고 메인 화면으로 돌아갑니다."),
                          primaryButton: .destructive(Text("예"),
                                                      action: {
                        // 계정 삭제 로직
                    }), secondaryButton: .cancel(Text("아니오")))
                }
                
                Button(action:{
                    unregisterAlert.toggle()
                }){
                    Text("회원탈퇴")
                        .font(.footnote)
                }
                .alert(isPresented: $unregisterAlert) {
                    Alert(title: Text("회원 탈퇴를 하시겠습니까?"),
                          message:
                            Text("회원을 탈퇴할 경우 해당 계정과 \n데이터 복구가 어렵습니다."),
                          primaryButton: .destructive(Text("회원 탈퇴"),
                                                      action: {
                        // 회원 탈퇴 로직
                    }), secondaryButton: .cancel(Text("취소")))
                }
            }
            .padding()
            Spacer()
        }
        .navigationTitle("설정")
    }

}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
