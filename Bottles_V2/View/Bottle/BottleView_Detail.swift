//
//  BottleView_Detail.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

// MARK: - Tasting Notes, Information, Pairing
struct BottleView_Detail: View {
    var bottleData: BottleModel

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
                            Text(bottleData.itemAroma)
                        }
                        HStack(spacing: 5) {
                            // Taste
                            Text("Taste")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text(bottleData.itemTaste)
                        }
                        HStack(spacing: 5) {
                            // Finish
                            Text("Finish")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text(bottleData.itemFinish)
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
                            Text(bottleData.itemType)
                        }
                        HStack(spacing: 5) {
                            // 용량
                            Text("용량")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text("\(bottleData.itemML)ML")
                        }
                        HStack(spacing: 5) {
                            // 도수
                            Text("도수")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text(bottleData.stringItemDegree)
                        }
                        HStack(spacing: 5) {
                            // 국가
                            Text("국가")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text(bottleData.itemNation)
                        }
                        HStack(spacing: 5) {
                            // 품종
                            Text("품종")
                                .frame(maxWidth: 38, alignment: .leading)
                            Text(bottleData.itemVarities[0])
                        }
                    }
                    .modifier(contentModifier())
                }
                
                VStack(alignment: .leading) {
                    // MARK: - Pairing
                    Text("Pairing")
                        .modifier(titleModifier())
                    
                    Text(bottleData.itemPairing)
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
