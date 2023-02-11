//
//  ReservationView_OutOfFocus.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/02/06.
//

import SwiftUI

struct ReservationView_OutOfFocus: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.opacity(0.2)
            }
            .toolbarBackground(Color.black.opacity(0.2), for: .navigationBar)
        }
        .ignoresSafeArea()
    }
}

struct ReservationView_OutOfFocus_Previews: PreviewProvider {
    static var previews: some View {
        ReservationView_OutOfFocus()
    }
}
