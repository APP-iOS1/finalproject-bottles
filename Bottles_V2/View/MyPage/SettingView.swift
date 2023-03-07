//
//  SettingView.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct SettingView: View {
    @EnvironmentObject var authStore: AuthStore
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    /// 로그아웃 Alert창을 띄웁니다.
    @State private var logoutAlert: Bool = false
    /// 회원 탈퇴 Alert창을 띄웁니다.
    @State private var unregisterAlert: Bool = false
    
    @Binding var selection: Int
    var body: some View {
        VStack {
            // MARK: - 휴대폰 번호 변경, 알림 설정
            List {
                NavigationLink(destination: ChangePhoneNumberView()) {
                    Text("휴대폰 번호 변경")

                }
                .listRowSeparator(.hidden)
                Button(action: {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                                if UIApplication.shared.canOpenURL(url) {
                                    Task {
                                        await UIApplication.shared.open(url)
                                    }
                                }
                            }
                }){
                    HStack {
                        Text("알림 설정")

                        Spacer()
                        Image(systemName: "chevron.forward")
                            .font(.footnote)
                            .bold()
                            .foregroundColor(.secondary)
                            .opacity(0.6)
                            
                    }
                }
            }
            .font(.bottles16)
            .listStyle(.plain)
            .frame(height: 80)
            .scrollDisabled(true)
            .padding(.top)
            
            // MARK: - 로그아웃, 회원탈퇴 HStack
            HStack {
                Spacer()
                
                // MARK: - 로그아웃 버튼
                Button(action:{
                    logoutAlert = true
                   
                    print("\(authStore.loginPlatform)")
                }){
                    Text("로그아웃")
                        .font(.bottles12)
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                
                
                // MARK: - 회원탈퇴 버튼
                Button(action:{
                    unregisterAlert.toggle()
                
                }){
                    Text("회원탈퇴")
                        .font(.bottles12)
                        .foregroundColor(.black)
                }
                .alert(isPresented: $unregisterAlert) {
                    Alert(title: Text("회원 탈퇴를 하시겠습니까?"),
                          message:
                            Text("회원을 탈퇴할 경우 해당 계정과 \n데이터 복구가 어렵습니다."),
                          primaryButton: .destructive(Text("회원 탈퇴"),
                                                      action: {
                        // TODO: 회원 탈퇴 로직
                        authStore.deleteUser(userEmail: authStore.currentUser?.email ?? "")
                        selection = 1
                    }), secondaryButton: .cancel(Text("취소")))
                }
            }
            .padding()
            Spacer()
        }
        .navigationTitle("설정")
        .customAlert(
            isPresented: $logoutAlert,
            message: "로그아웃 하시겠습니까?",
            primaryButtonTitle: "확인",
            primaryAction: {
            authStore.allLogout()
            selection = 1 },
            withCancelButton: true)
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading: backButton)
    }
    
    var backButton : some View {
        Button(
            action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")    // back button 이미지
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(Color.black)
            }

    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView(selection: .constant(1)).environmentObject(AuthStore())
    }
}
