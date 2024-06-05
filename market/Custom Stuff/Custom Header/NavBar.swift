//
//  NavBar.swift
//  market
//
//  Created by Nicholas Nelson on 5/7/24.
//

import Foundation
import SwiftUI

struct NavBarScrollTracker: View {
    @ObservedObject private var navBarInfo = NavBarInfo.shared

    var body: some View {
        GeometryReader { geometry in
            Color.clear
                .frame(width: 0, height: 1)
                .onChange(of: geometry.frame(in: .global).minY) {
                    navBarInfo.onScroll(geometry.frame(in: .global).minY)
                }
        }
    }
}

class NavBarInfo: ObservableObject {
    static let shared = NavBarInfo()
    
    @Published var height: CGFloat = 170
    @Published var offset: CGFloat = 0
    private var lastScrollOffset: CGFloat = 0
    private var barFullyOut: Bool = true;
    
    func onScroll(_ newValue: CGFloat) {
        print(newValue)
        if(newValue > 0) { // Rubberbanding - when the scroll is artifically past the top of the screen
            offset = 0
            barFullyOut = true;
            return;
        }
        let delta = newValue - lastScrollOffset
        lastScrollOffset = newValue
        if(delta > 0) { // Swipe Down, Appear
            if(offset + delta < 0) {
                offset = offset + delta
            } else if(!barFullyOut) {
                offset = 0
                barFullyOut = true;
            }
        } else { // Swipe Up, Hide
            let fullyRetracted = -height - 5
            let newPosition = offset - abs(delta)
            if (fullyRetracted < newPosition) {
                offset = offset - abs(delta)
                barFullyOut = false;
            } else {
                offset = fullyRetracted
            }
        }
    }
}
