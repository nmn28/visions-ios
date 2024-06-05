//
//  StyledNavButton.swift
//  market
//
//  Created by Nicholas Nelson on 12/27/23.
//

import SwiftUI

struct StyledNavButton: View {
    var imageName: String
    var text: String
    var destination: AnyView  // Use AnyView to allow any type of view

    var body: some View {
        NavigationLink(destination: destination) {
            ZStack {
                RoundedRectangle(cornerRadius: 7.5)
                    .fill(Color.clear)
                    .frame(width: 30, height: 30)
                Image(systemName: imageName)
            }
            Text(text)
                .padding(.leading, 9)
        }
    }
}

#Preview {
    StyledNavButton(imageName: "lock", text: "privacy", destination: AnyView(Text("Privacy View")))
}
