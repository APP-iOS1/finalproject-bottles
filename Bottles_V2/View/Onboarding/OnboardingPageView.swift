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
        VStack(alignment: .center) {
            
            Text(title)
                .font(.bottles24)
                .fontWeight(.bold)
                .frame(alignment: .center)
            
            Image(imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)

        }
        .padding()
        
    }
}

//struct OnboardingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageView()
//    }
//}
