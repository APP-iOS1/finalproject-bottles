//
//  ReservationView.swift
//  Bottles_V2
//
//  Created by hyemi on 2023/01/23.
//

import SwiftUI
import Combine

// MARK: - 예약하기 Modal Custom View
/// Custom View의 present 및 dismiss 기능을 위한 뷰입니다.
/// 데이터 적용이 필요한 부분은 ReservationView_Content입니다.
struct ReservationView: View {
    //@EnvironmentObject var path: Path
    @EnvironmentObject var bottleDataStore: BottleDataStore
    var bottleData: BottleModel
    @Binding var isShowing: Bool
    @State var offset = UIScreen.main.bounds.height
    @State private var isDragging = false
    
    
    let heightToDisappear = UIScreen.main.bounds.height
    let outOfFocusOpacity: CGFloat = 0.7
    let minimumDragDistanceToHide: CGFloat = 150
    
    var body: some View {
        Group {
            if isShowing {
                ZStack {
                    //outOfFocusArea
                    sheetView
                }
                
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
    
    var outOfFocusArea: some View {
        Group {
            if isShowing {
                ReservationView_OutOfFocus(opacity: outOfFocusOpacity) {
                    self.isShowing = false
                }
            }
        }
    }
    
    var sheetView: some View {
        VStack {
            ReservationView_Content(bottleData: bottleData)
                .background(.white)
                .cornerRadius(15)
                //.cornerRadius(12, corners: [.topLeft, .topRight])
                .offset(y: offset)
                .gesture(interactiveGesture)
                //.environmentObject(path)
                .onTapGesture {
                    hide()
                }
        }
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
