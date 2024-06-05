//
//  ContextModifier.swift
//  market
//
//  Created by Nicholas Nelson on 4/16/24.
//

import SwiftUI

struct ContextModifier: ViewModifier {

    // ContextMenu Modifier...
    var card: Card
    
    func body(content: Content) -> some View {
        
        content
            .contextMenu(menuItems: {

                Text("By \(card.author)")
            })
            .contentShape(RoundedRectangle(cornerRadius: 5))
    }
}
