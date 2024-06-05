//
//  CustomDividerView.swift
//  market
//
//  Created by Nicholas Nelson on 11/29/23.
//

import SwiftUI

struct CustomDivider: View {
    @Environment(\.colorScheme) var colorScheme
    var thickness: CGFloat = 1 // Default thickness
    
    var body: some View {
        Rectangle()
            .fill(colorScheme == .dark ? .white : .black)
            .frame(height: thickness)
    }
}

#Preview {
    CustomDivider()
}
