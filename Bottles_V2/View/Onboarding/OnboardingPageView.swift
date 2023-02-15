//
//  OnboadingPageView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String?
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            Text(title)
                .font(.bottles24)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)

        }
    }
}

//struct OnboardingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageView()
//    }
//}
