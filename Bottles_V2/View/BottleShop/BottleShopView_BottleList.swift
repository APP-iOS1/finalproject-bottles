//
//  BottleShopView_BottleList.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/01/18.
//

import SwiftUI

// 바틀샵뷰 내 "상품 검색" 뷰 - "바틀 셀"
struct BottleShopView_BottleList: View {
    @EnvironmentObject var userStore: UserStore
    @State private var bookmarkToggle: Bool = false
    @State private var bookmarkToggle_fill: Bool = false
    @State private var bookmarkToggle_empty: Bool = false
    
    var selectedItem: BottleModel
    
    var body: some View {
        ZStack{
            VStack{
                HStack{
                    
                    Spacer()
                        .frame(width: 10)
                    
                    // 데이터 연동 시 "바틀 이미지" 연동
                    AsyncImage(url: URL(string: String(selectedItem.itemImage)), content:  { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 128)
                    }, placeholder: {
                        ZStack{
                            Rectangle()
                                .frame(width: 100, height: 128)
                                .foregroundColor(.gray_f7)
                            
                            VStack{
                                Image(systemName: "wineglass")
                                    .font(.system(size: 25))
                                
                                Spacer()
                                    .frame(height: 5)
                                
                                Text("사진 준비 중이에요!")
                                    .font(.bottles11)
                                    .fontWeight(.semibold)
//                                Spacer()
                            }
                            .foregroundColor(.gray)
                        }
                    })
                    .padding(5)
                    .background{Color.gray_f7}
                    .cornerRadius(12)
                    .frame(width: 100, height: 128)
                    
                    Spacer()
                        .frame(width: 20)
                    
                    VStack(alignment: .leading){
                        
                        HStack{
                            // 데이터 연동 시 "바틀 이름" 연동
                            Text(selectedItem.itemName)
                                .font(.bottles14)
                                .fontWeight(.medium)
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
                                    if compareMyFollowBottleID(selectedItem.id) == true {
                                        bookmarkToggle = false
                                        userStore.deleteFollowItemId(selectedItem.id)
                                    }

                                    if compareMyFollowBottleID(selectedItem.id) == false {
                                        bookmarkToggle = true
                                        userStore.addFollowItemId(selectedItem.id)
                                    }
                                    
                                }) {
                                    Image(compareMyFollowBottleID(selectedItem.id) ? "BookMark.fill" : "BookMark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 15, height: 18)
                                        .padding(.horizontal, 10)
                                }
                                
//                                Button(action: {
//                                    withAnimation(.easeOut(duration: 0.5)) {
//                                        bookmarkToggle.toggle()
//                                    }
//                                    
//                                    if bookmarkToggle == true{
//                                        withAnimation(.easeOut(duration: 1.5)) {
//                                            bookmarkToggle_fill.toggle()
//                                            print("북마크 완료")
//                                        }
//                                        
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//                                            bookmarkToggle_fill.toggle()
//                                        }
//                                    }
//                                    
//                                    if bookmarkToggle == false{
//                                        withAnimation(.easeOut(duration: 1.5)) {
//                                            bookmarkToggle_empty.toggle()
//                                            print("북마크 해제")
//                                        }
//                                        
//                                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5){
//                                            bookmarkToggle_empty.toggle()
//                                        }
//                                    }
//                                    
//                                }) {
//                                    Image(bookmarkToggle ? "BookMark.fill" : "BookMark")
//                                        .resizable()
//                                        .aspectRatio(contentMode: .fit)
//                                        .frame(width: 15)
//                                        .padding(.trailing, 5)
//                                }
                            }
                        }
                        
                        //                    Spacer()
                        //                        .frame(height: 10)
                        //
                        
                        // 데이터 연동 시 "바틀 가격" 연동
                        HStack{
                            Text("\(selectedItem.itemPrice)")
                                .padding(.trailing, -5)
                            Text("원")
                        }
                        .font(.bottles18)
                        .fontWeight(.heavy)
                        
                        HStack{
                            // 데이터 연동 시 "바틀 카테고리" 연동
                            Text(selectedItem.itemType)
                                .lineLimit(1)
                                .padding(.horizontal)
                                .padding(.vertical, 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.gray, lineWidth: 0.7)
                                )
                            
                            // 데이터 연동 시 "itemTaste" 연동
                            Text(selectedItem.itemTaste)
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
            
            // MARK: - "BookMark 완료"시 애니메이션
//            if bookmarkToggle_fill{
//                HStack{
//                    Image("BookMark.fill")
//                    Text("북마크가 완료되었습니다.")
//                        .foregroundColor(.gray)
//                        .font(.bottles11)
//
//                }
//                .zIndex(1)
//                .transition(.opacity.animation(.easeIn))
//                .background{
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 300, height: 30)
//                        .foregroundColor(.gray_f7)
//                }
//                .offset(y: 300)
//            }
//
//            // MARK: - "BookMark 해제"시 애니메이션
//            if bookmarkToggle_empty{
//                HStack{
//                    Image("BookMark")
//                    Text("북마크가 해제되었습니다.")
//                        .foregroundColor(.gray)
//                        .font(.bottles11)
//
//                }
//                .zIndex(1)
//                .transition(.opacity.animation(.easeIn))
//                .background{
//                    RoundedRectangle(cornerRadius: 10)
//                        .frame(width: 300, height: 30)
//                        .foregroundColor(.gray_f7)
//                }
//                .offset(y: 300)
//            }
            
        }
    }
    
    func compareMyFollowBottleID(_ bottleId: String) -> Bool {
        return (userStore.user.followItemList.filter { $0 == bottleId }.count != 0) ? true : false
    }
}



//struct BottleShopView_BottleList_Previews: PreviewProvider {
//    static var previews: some View {
//        BottleShopView_BottleList(selectedItem: BottleItem22(id: UUID(), name: "화이트 와인", price: 350000, category: "화이트", tag: "와인", use: "메인"))
//    }
//}
