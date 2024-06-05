//
//  SlideInTransition.swift
//  market
//
//  Created by Nicholas Nelson on 5/13/24.
//

import SwiftUI

struct SlideInTransition: ViewModifier {
    @Binding var isPresented: Bool

    func body(content: Content) -> some View {
        ZStack {
            if isPresented {
                content
                    .transition(.move(edge: .trailing))
                    .animation(.easeInOut(duration: 0.3), value: isPresented)
            }
        }
    }
}

extension View {
    func slideInTransition(isPresented: Binding<Bool>) -> some View {
        self.modifier(SlideInTransition(isPresented: isPresented))
    }
}
