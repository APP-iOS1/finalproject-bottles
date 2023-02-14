//
//  OnboardingLastPageView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingLastPageView: View {
    let imageName: String
    let title: String
//    let subtitle: String
    
    @Binding var isFirstLaunching: Bool
    
    var body: some View {
        VStack(alignment: .center) {
            
            Text(title)
                .font(.bottles24)
                .fontWeight(.bold)
                .frame(alignment: .center)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
                        
            // 온보딩 완료 버튼.
            // AppStorage의 isFirstLaunching 값을 false로 바꾸기 때문에, 다음번에 앱을 실행할 때는 OnboardingTabView를 띄우지 않음.
            Button {
                isFirstLaunching.toggle()
            } label: {
                Text("시작하기")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 200, height: 50)
                    .background(Color.blue)
                    .cornerRadius(6)
            }
            .foregroundColor(.accentColor)
            .padding()
        }
        .padding()
    }
}

//struct OnboardingLastPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingLastPageView()
//    }
//}
