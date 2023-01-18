//
//  OtherBottleView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/18.
//

import SwiftUI

struct OtherBottleView: View {
    @State private var checkBookmark: Bool = false
    var tagList: [String] = ["위스키", "한정판", "스모키"]
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
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
                                ForEach(tagList, id: \.self) { tag in
                                    ZStack {
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(.black, lineWidth: 1)
                                            .opacity(0.4)
                                            .frame(width: 54, height: 21)
                                        Text(tag)
                                            .font(.caption)
                                            .opacity(0.4)
                                    }
                                }
                            }
                            .frame(height: 30)
                        }
                        Button(action: {
                            checkBookmark.toggle()
                        }) {
                            Image(systemName: checkBookmark ? "bookmark.fill" : "bookmark")
                                .resizable()
                                .frame(width: 15, height: 19)
                        }
                        
                    }
                    .padding(10)
                }

            }
        }
    }
}

struct OtherBottleView_Previews: PreviewProvider {
    static var previews: some View {
        OtherBottleView()
    }
}
