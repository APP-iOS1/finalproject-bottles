//
//  OnboardingFirstView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingFirstView: View {
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("바틀 예약 및 픽업은 등록된\n바틀샵에서만 진행할 수 있어요!")
                .font(.bottles24)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.vertical)
            
            HStack {
                Image("MapMarker.fill")
                Text("등록된 바틀샵")
                
                Divider()
                    .frame(width: 20, height: 20)
                
                Image("MapMarker")
                Text("미등록된 바틀샵")
            }
            .font(.bottles14)
            
            Image("Onboarding0")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
        .scaledToFit() // 기기별 호환 위해 적용
    }
}

struct OnboardingFirstView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirstView()
    }
}
