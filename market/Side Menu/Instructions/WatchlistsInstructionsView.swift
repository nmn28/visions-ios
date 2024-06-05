//
//  WatchlistsInstructionsView.swift
//  market
//
//  Created by Nicholas Nelson on 5/1/24.
//

import SwiftUI

struct WatchlistsInstructionsView: View {
    var body: some View {
        List {
            Section{
                
                StyledNavButton(
                    imageName: "globe",
                    text: "All",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
                StyledNavButton(
                    imageName: "circle.grid.2x1",
                    text: "Escrow Options",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
                
                StyledNavButton(
                    imageName: "chart.xyaxis.line",
                    text: "Stock Options",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
                
                
                StyledNavButton(
                    imageName: "flowchart",
                    text: "Categories",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
                StyledNavButton(
                    imageName: "hammer",
                    text: "Disputes",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
                StyledNavButton(
                    imageName: "person.circle",
                    text: "Profiles",
                    destination: AnyView(Text("Walkthrough Detail"))
                )
                
            } header: {
                
                Text("Feed Options")
            } footer: {
                
                Text("Get to know the feed options in your watchlists tab.")
            }
        }
    }
}

#Preview {
    WatchlistsInstructionsView()
}
