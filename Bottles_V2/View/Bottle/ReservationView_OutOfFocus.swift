//
//  ReservationView_OutOfFocus.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/06.
//

import SwiftUI

struct ReservationView_OutOfFocus: View {
    let opacity: CGFloat
    let callback: (() -> ())?
    
    public init(
        opacity: CGFloat = 0.7,
        callback: (() -> ())? = nil
    ) {
        self.opacity = opacity
        self.callback = callback
    }
    
    var greyView: some View {
        Rectangle()
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .background(Color.gray)
            .opacity(Double(opacity))
            .onTapGesture {
                callback?()
            }
            .edgesIgnoringSafeArea(.all)
    }
    
    public var body: some View {
        greyView
    }
}

struct ReservationView_OutOfFocus_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView_OutOfFocus()
    }
}
