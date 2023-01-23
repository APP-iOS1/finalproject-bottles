//
//  ReservationView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI
import Combine

struct ReservationView: View {
    @Binding var isShowing: Bool
    @State var offset = UIScreen.main.bounds.height
    @State private var isDragging = false
    
    let heightToDisappear = UIScreen.main.bounds.height
    let minimumDragDistanceToHide: CGFloat = 150
    
    var body: some View {
        Group {
            if isShowing {
                sheetView
            }
        }
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
            .frame(width: 40, height: 4)
            .foregroundColor(.gray)
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
            }
            .cornerRadius(15)
            .offset(y: offset)
            .gesture(interactiveGesture)
            .onTapGesture {
                hide()
            }
        }
        .frame(height: 320)
    }
    
    
    func onUpdateIsShowing(_ isShowing: Bool) {
        if isShowing && isDragging {
            return
        }
        offset = isShowing ? 0 : heightToDisappear
    }
}

//struct ReservationView_Previews: PreviewProvider {
//    static var previews: some View {
//        ReservationView(isShowing: <#Binding<Bool>#>)
//    }
//}
