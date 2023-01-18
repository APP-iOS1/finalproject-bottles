//
//  PickUpListCell.swift
//  Bottles_V2
//
//  Created by BOMBSGIE on 2023/01/18.
//

import SwiftUI

struct PickUpListCell: View {
    var body: some View {
        VStack{
            HStack {
                Text("2023.01.18")
                    .font(.headline)
                Spacer()
                
                Text("예약 확정")
                    .font(.caption)
                    .overlay{
                        RoundedRectangle(cornerRadius: 10)
                            .stroke()
                            .frame(width: 60, height: 20)
                    }
                    .foregroundColor(.gray)
                    .padding(.trailing, 10)
            }
            .padding(.vertical)
            HStack{
                VStack(alignment:.leading){
                    Text("픽업 매장")
                        .padding(.bottom, -3)
                    Text("상품 명")
                }
                VStack(alignment:.leading){
                    Text("은노샵")
                        .padding(.bottom, -3)
                    Text("디 오리니널 골드바 위스키")
                }
                Spacer()
            }
        }
        .foregroundColor(.black)
        .padding(.horizontal)
    }
}

struct PickUpListCell_Previews: PreviewProvider {
    static var previews: some View {
        PickUpListCell()
    }
}
