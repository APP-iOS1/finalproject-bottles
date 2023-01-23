//
//  ReservationView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI
import Combine

struct ReservationView: View {
    @State var offset = UIScreen.main.bounds.height
    @Binding var isShowing: Bool
    @State var isDragging = false
    
    let heightToDisappear = UIScreen.main.bounds.height
    let minimumDragDistanceToHide: CGFloat = 150
    
    var body: some View {
        Group {
            if isShowing {
                sheetView
            }
        }
        //.animation(.default)
        .onReceive(Just(isShowing), perform: { isShowing in
            onUpdateIsShowing(isShowing)
        })
    }
    
    func hide() {
        offset = heightToDisappear
        isDragging = false
        isShowing = false
    }
    
    var topHalfMiddleBar: some View {
        Capsule()
            .frame(width: 36, height: 5)
            .foregroundColor(Color.black)
            .padding(.vertical, 5.5)
            .opacity(0.2)
    }
    
    func dragGestureOnChange(_ value: DragGesture.Value) {
        isDragging = true
        if value.translation.height > 0 {
            offset = value.location.y
            let diff = abs(value.location.y - value.startLocation.y)
            
            let conditionOne = diff > minimumDragDistanceToHide
            let conditionTwo = value.location.y >= 200
            
            
            if conditionOne || conditionTwo {
                hide()
            }
        }
    }
        
    var interactiveGesture: some Gesture {
        DragGesture()
            .onChanged({ (value) in
                dragGestureOnChange(value)
            })
            .onEnded({ (value) in
                isDragging = false
            })
    }
    
    var sheetView: some View {
        VStack {
            Spacer()
            
            VStack {
                topHalfMiddleBar
                ReservationView_Sheet()
                Text("").frame(height: 20) // empty space
            }
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(interactiveGesture)
            .onTapGesture {
                hide()
            }
        }
    }
    
    
    func onUpdateIsShowing(_ isShowing: Bool) {
        if isShowing && isDragging {
            return
        }
        
        DispatchQueue.main.async {
            offset = isShowing ? 0 : heightToDisappear
        }
    }
  
}

//struct ReservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView()
//    }
//}
