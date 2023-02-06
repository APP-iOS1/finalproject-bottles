//
//  BottleView_Detail.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

// MARK: - Tasting Notes, Information, Pairing
struct BottleView_Detail: View {
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    // MARK: - Tasting Notes
                    Text("Tasting Notes")
                        .modifier(titleModifier())
                        .padding(.vertical, 3)
                    
                    Group {
                        HStack(spacing: 5) {
                            // Aroma
                            Text("Aroma")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("사과, 시트러스, 그린 애플")
                        }
                        HStack(spacing: 5) {
                            // Taste
                            Text("Taste")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("복숭아, 파인애플, 망고, 미네랄")
                        }
                        HStack(spacing: 5) {
                            // Finish
                            Text("Finish")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("꽃, 구아바, 체리, 달콤한")
                        }
                    }
                    .modifier(contentModifier())
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    // MARK: - Information
                    Text("Information")
                        .modifier(titleModifier())
                    
                    Group {
                        HStack(spacing: 5) {
                            // 종류
                            Text("종류")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("스파클링 와인")
                        }
                        HStack(spacing: 5) {
                            // 용량
                            Text("용량")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("750ml")
                        }
                        HStack(spacing: 5) {
                            // 도수
                            Text("도수")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("8%")
                        }
                        HStack(spacing: 5) {
                            // 국가
                            Text("국가")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("스페인")
                        }
                        HStack(spacing: 5) {
                            // 품종
                            Text("품종")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("모스카토")
                        }
                    }
                    .modifier(contentModifier())
                }
                
                VStack(alignment: .leading) {
                    // MARK: - Pairing
                    Text("Pairing")
                        .modifier(titleModifier())
                    
                    Text("회, 생선, 랍스타 등의 해산물")
                        .modifier(contentModifier())
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color("AccentColor").opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical, 5)
        }
    }
}

// MARK: - Tasting Notes, Information, Pairing의 Title Modifier
struct titleModifier: ViewModifier {
    var font = Font.bottles14
    var fontWeight = Font.Weight.bold
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
            .padding(.vertical, 3)
    }
}

// MARK: - Tasting Notes, Information, Pairing의 Content Modifier
struct contentModifier: ViewModifier {
    var font = Font.bottles12
    var fontWeight = Font.Weight.regular
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
    }
}

//
//struct BottleView_Info_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleView_Detail()
//    }
//}
