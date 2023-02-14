//
//  OnboadingPageView.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Image(systemName: imageName)
                .font(.system(size: 100))
                .padding()
            
            Text(title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            Text(subtitle)
                .font(.title2)
        }
        .padding()
        
    }
}

//struct OnboardingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageView()
//    }
//}
