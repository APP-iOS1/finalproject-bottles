//
//  BottleView_Detail.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI

// MARK: - Tasting Notes, Information, Pairing
struct BottleView_Detail: View {
    var tastingNotesTitle: [String] = ["Aroma", "Taste", "Finish"]
    var tastingNotesContent: [String] = ["사과, 시트러스, 그린 애플", "복숭아, 파인애플, 망고, 미네랄", "꽃, 구아바, 체리, 달콤한"]
    var informationTitle: [String] = ["종류", "용량", "도수", "국가", "품종"]
    var informationContent: [String] = ["스파클링 와인", "750ml", "8%", "스페인", "모스카토"]
    
    var body: some View {
        VStack(alignment: .leading) {
            VStack(alignment: .leading, spacing: 15) {
                VStack(alignment: .leading, spacing: 5) {
                    // MARK: - Tasting Notes
                    Text("Tasting Notes")
                        .padding(.vertical, 3)
                    
                    ForEach(0..<tastingNotesTitle.count, id: \.self) { index in
                        HStack {
                            Text(tastingNotesTitle[index])
                            Text(tastingNotesContent[index])
                        }
                    }
                    .modifier(contentModifier())
                }
                
                VStack(alignment: .leading, spacing: 5) {
                    // MARK: - Information
                    Text("Information")
                        .modifier(titleModifier())
                    
                    ForEach(0..<informationTitle.count, id: \.self) { index in
                        HStack {
                            Text(informationTitle[index])
                            Text(informationContent[index])
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
            .background(Color(UIColor.systemGray5))
            .cornerRadius(10)
            .padding()
        }
    }
}

// MARK: - Tasting Notes, Information, Pairing의 Title Modifier
struct titleModifier: ViewModifier {
    var font = Font.bottles15
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
    var font = Font.bottles13
    var fontWeight = Font.Weight.medium
    
    func body(content: Content) -> some View {
        content
            .font(font)
            .fontWeight(fontWeight)
    }
}


struct BottleView_Info_Previews: PreviewProvider {
    static var previews: some View {
        BottleView_Detail()
    }
}
