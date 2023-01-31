//
//  CartCell.swift
//  Bottles_V2
//
//  Created by 장다영 on 2023/01/18.
//

import SwiftUI

// MARK: - 장바구니 Cell
/// 장바구니 리스트의 셀

struct CartCell: View {
    
    @State private var isSelected: Bool = false
    @State private var amount : Int = 1
    @Binding var isAllSelected : Bool
    @Binding var allSelectButtonCheck : Bool
    
    var body: some View {
        VStack {
            // MARK: - Cell의 상단
            /// 선택버튼 , 바틀샵 이름, 삭제 버튼
            HStack {
                selectButton
                Text("바틀샵 이름")
                    .font(.bottles13)
                    .bold()
                Spacer()
                deleteButton
            }
            .padding(.bottom, -10)
            .padding(.top, -5)
            
            // MARK: - Cell의 하단
            /// bottle의 사진, 상품명, 가격, 품목의 개수와 증감 버튼
            HStack {
                // bottle의 사진
                AsyncImage(url: URL(string: ""))
                    .frame(width: UIScreen.main.bounds.size.width/4, height: UIScreen.main.bounds.size.width/4)
                    .padding(.trailing, 15)
                
                // 상품명, 가격, 품목의 개수, 증감버튼
                VStack(alignment: .leading, spacing: 5) {
                    Text("디 오리지널 골드바 위스키")
                        .font(.bottles13)
                        .padding(.bottom,3)
                    Text("350,000원")
                        .font(.bottles15)
                        .bold()
                    Spacer()
                    increaseButtonView
                        .padding(.bottom, 2)
                }
                .padding(.trailing, 30)
                
            }
            .frame(width:UIScreen.main.bounds.size.width ,height: UIScreen.main.bounds.size.width/4)
        }
        .padding(.bottom)
        .onChange(of: isAllSelected) { value in
            if (allSelectButtonCheck) {
                isSelected = value
            }
        }
    }
    
    // MARK: -View : 선택 버튼
    private var selectButton : some View {
        Button {
            allSelectButtonCheck = false
            if isSelected {
                isAllSelected.toggle()
            }
            isSelected.toggle()
            
        } label : {
            Image(systemName: (isSelected) ? "checkmark.circle.fill" : "circle")
        }
        .padding([.leading, .top, .bottom])
    }
    
    // MARK: -View : 삭제 버튼
    private var deleteButton : some View {
        Button {
            // 뷰에서 삭제하는 기능 추가
        } label : {
            Image(systemName: "multiply")
        }
        .padding()
    }
    
    // MARK: -View : 증감 버튼
    private var increaseButtonView : some View {
        HStack {
            Button {
                if amount > 1 {
                    amount -= 1
                }
            } label : {
                Image(systemName: "minus")
            }
            .padding([.leading, .trailing])
            .padding([.top, .bottom], 15)
            Text("\(amount)")
                .font(.bottles15)
                .bold()
                .frame(width: 22)
            
            Button {
                amount += 1
            } label : {
                Image(systemName: "plus")
            }
            .padding([.leading, .trailing])
        }
        .overlay(
            Capsule()
                .stroke()
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.size.width/3)
        )
    }
}

struct CartCell_Previews: PreviewProvider {
    @State var test = false
    static var previews: some View {
        CartCell(isAllSelected: .constant(false), allSelectButtonCheck: .constant(false))
    }
}
