//
//  BookMarkToggle.swift
//  Bottles_V2
//
//  Created by youngseo on 2023/02/14.
//

import SwiftUI

struct BookMarkToggle: View {
    
    @Binding var bookmarkToggle_fill: Bool
    @Binding var bookmarkToggle_empty: Bool
    
    var body: some View {
        // MARK: - "BookMark 완료"시 애니메이션
        if bookmarkToggle_fill{
            HStack{
                Image("BookMark.fill")
                Text("북마크가 완료되었습니다.")
                    .foregroundColor(.black)
                    .font(.bottles11)
                
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 30)
                    .foregroundColor(.gray_f7)
            }
            .offset(y: 300)
        }
        
        // MARK: - "BookMark 해제"시 애니메이션
        if bookmarkToggle_empty{
            HStack{
                Image("BookMark")
                Text("북마크가 해제되었습니다.")
                    .foregroundColor(.black)
                    .font(.bottles11)
                
            }
            .zIndex(1)
            .transition(.opacity.animation(.easeIn))
            .background{
                RoundedRectangle(cornerRadius: 10)
                    .frame(width: 300, height: 30)
                    .foregroundColor(.gray_f7)
            }
            .offset(y: 300)
        }
    }
}

//struct BookMarkToggle_Previews: PreviewProvider {
//    static var previews: some View {
//        BookMarkToggle()
//    }
//}
