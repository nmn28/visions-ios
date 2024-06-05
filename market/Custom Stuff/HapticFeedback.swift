//
//  HapticFeedback.swift
//  market
//
//  Created by Nicholas Nelson on 3/31/24.
//

import SwiftUI

struct HapticFeedbackViewModifier: ViewModifier {
    var style: UIImpactFeedbackGenerator.FeedbackStyle = .medium
    
    func body(content: Content) -> some View {
        content
            .onTapGesture {
                triggerHapticFeedback()
            }
    }
    
    private func triggerHapticFeedback() {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}

extension View {
    func hapticFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle = .medium) -> some View {
        self.modifier(HapticFeedbackViewModifier(style: style))
    }
}

struct HapticFeedbackDemoView: View {
    var body: some View {
        Button("Tap Me") {
            // This is where you might toggle the side menu or perform some action
            print("Button tapped")
        }
        .hapticFeedback(style: .medium)
    }
}

// A preview provider for HapticFeedbackDemoView
struct HapticFeedbackDemoView_Previews: PreviewProvider {
    static var previews: some View {
        HapticFeedbackDemoView()
    }
}
