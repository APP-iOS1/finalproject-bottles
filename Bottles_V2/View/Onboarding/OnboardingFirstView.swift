//
//  OnboardingFirstView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingFirstView: View {
    var body: some View {
        VStack(alignment: .center) {
            Text("바틀 예약 및 픽업은 등록된\n바틀샵에서만 진행할 수 있어요!")
                .frame(alignment: .center)
                .font(.bottles24)
                .fontWeight(.bold)
            
            VStack{
                HStack {
                    Image("MapMarker")
                    Text("등록된 바틀샵")
                }
                
                HStack {
                    Image("MapMarker.fill")
                    Text("미등록된 바틀샵")
                }
                .padding()
            }.font(.bottles14)
            
            Image("Onboarding0")
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct OnboardingFirstView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingFirstView()
    }
}
