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
                    .padding(5)
                    .background{Color.gray_f7}
                    .cornerRadius(12)
                    .frame(height: 128)
                
                Spacer()
                    .frame(width: 16)
                
                VStack(alignment: .leading){
                    
                    HStack{
                        Text(selectedItem.name)
                            .font(.bottles14)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.leading)
                            .padding(.bottom, -7)
                        
                        Spacer()
                        
                        VStack{
                            Spacer()
                                .frame(height: 10)
                            
                            Button(action: {
                                withAnimation(.easeOut(duration: 0.5)) {
                                    bookmarkToggle.toggle()
                                }
                            }) {
                                Image(bookmarkToggle ? "BookMark.fill" : "BookMark")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 15)
                            }
                        }
                    }
                    
//                    Spacer()
//                        .frame(height: 10)
//                    
                    Text(selectedItem.price)
                        .font(.bottles18)
                        .fontWeight(.heavy)
                    
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
                    .font(.bottles12)
                    .foregroundColor(.gray)
                    .padding(.top, -5)
                    
                    Spacer()
                        .frame(height: 30)
                }
                
                .frame(alignment: .leading)

                Spacer()
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
