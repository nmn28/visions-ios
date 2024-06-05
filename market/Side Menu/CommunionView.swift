//
//  CommunionView.swift
//  market
//
//  Created by Nicholas Nelson on 12/12/23.
//

import SwiftUI

struct CommunionView: View {
    var body: some View {
        VStack {
            List {
                HStack {
                    Image(systemName: "house")
                    Text("Create a Room")
                }
                HStack {
                    Image(systemName: "door.right.hand.open")
                    Text("Occupy")
                }
                HStack {
                    Image(systemName: "paintpalette")
                    Text("Color")
                }
                
                
                HStack {
                    Image(systemName: "apple.terminal")
                    Text("Developers")
                }
            }
        }
    }
}

#Preview {
    CommunionView()
}
