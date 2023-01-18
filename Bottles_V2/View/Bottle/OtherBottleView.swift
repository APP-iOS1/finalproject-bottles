//
//  OtherBottleView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct OtherBottleView: View {
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Text("이 바틀샵의 다른 상품")
                    .font(.subheadline)
                    .fontWeight(.bold)

                HStack(alignment: .top) {
                    Image("kilchoman")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 129, height: 129)
                        .background(Color(UIColor(red: 246/255, green: 243/255, blue: 238/255, alpha: 1.0)))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("킬호만 샤닉")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            Text("350,000원")
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            HStack {
                                ForEach(0..<3, id: \.self) { _ in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                            .opacity(0.4)
                                            .frame(width: 54, height: 21)
                                        Text("위스키")
                                            .font(.caption)
                                            .opacity(0.4)
                                    }
                                }
                            }
                            .frame(height: 30)
                        }
                        Image(systemName: "bookmark")
                            .resizable()
                            .frame(width: 15, height: 19)
                    }
                    .padding(10)
                }

            }
        }
        .padding()
    }
}

struct OtherBottleView_Previews: PreviewProvider {
    static var previews: some View {
        OtherBottleView()
    }
}
