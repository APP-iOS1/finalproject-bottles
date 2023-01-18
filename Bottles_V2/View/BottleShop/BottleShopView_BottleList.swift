//
//  BottleShopView_BottleList.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

struct BottleShopView_BottleList: View {
    @State private var bookmarkToggle = false
    
    var selectedItem: BottleItem22
    
    var body: some View {
        VStack {
            HStack{
                Image("whisky_Image1")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 90)
                
                VStack(alignment: .leading){
                    Text(selectedItem.name)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .padding(.bottom, -10)
                    
                    Spacer()
                        .frame(height: 10)
                    
                    Text(selectedItem.price)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                    
                    HStack{
                        Text(selectedItem.category ?? "")
                            .lineLimit(1)
                            .padding(.horizontal)
                            .padding(.vertical, 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.7)
                            )
                        Text(selectedItem.tag ?? "")
                            .lineLimit(1)
                            .padding(.horizontal)
                            .padding(.vertical, 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.7)
                                    
                            )
                        Text(selectedItem.use ?? "")
                            .lineLimit(1)
                            .padding(.horizontal)
                            .padding(.vertical, 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 0.7)
                            )
                    }
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .padding(.top, -5)
                    
                }
                
                .frame(alignment: .leading)

                Spacer()
                
                Button(action: {
                    withAnimation(.easeOut(duration: 0.5)) {
                        bookmarkToggle.toggle()
                    }
                }) {
                    Image(systemName: bookmarkToggle ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 15))
                        .foregroundColor(.black)
                        .padding(.trailing)
                }
            }
            .padding(.vertical)
            Divider()
            
        }
        .foregroundColor(.black)
//                    .frame(height: 400)
    }
}



struct BottleShopView_BottleList_Previews: PreviewProvider {
    static var previews: some View {
        BottleShopView_BottleList(selectedItem: BottleItem22(id: UUID(), name: "화이트 와인", price: "350,000원", category: "화이트", tag: "와인", use: "메인"))
    }
}
