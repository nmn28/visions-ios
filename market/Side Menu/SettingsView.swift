//
//  SettingsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/12/23.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
            List {
                Section{
                    StyledNavButton(
                        imageName: "platter.filled.bottom.iphone",
                        text: "Organize Tabs",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "hand.tap",
                        text: "Haptic Feedback",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "f.cursive",
                        text: "Fonts",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "paintpalette",
                        text: "Color Schemes",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                } header: {
                    
                    Text("User Interface")
                } footer: {
                    
                    Text("Control the app's appearance.")
                }
                
                Section{
                    StyledNavButton(
                        imageName: "chevron.left.forwardslash.chevron.right",
                        text: "Developers & API",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                }
                Section{
                    
                    StyledNavButton(
                        imageName: "lock.shield",
                        text: "Privacy",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "lifepreserver",
                        text: "Safety",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                } header: {
                    
                    Text("Privacy & Safety")
                } footer: {
                    
                    Text("Please reach out with any further thoughts, questions and concerns.")
                }
                
            }
        }
    }

#Preview {
    SettingsView()
}
