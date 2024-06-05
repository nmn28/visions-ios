//
//  RolesView.swift
//  market
//
//  Created by Nicholas Nelson on 3/31/24.
//

import SwiftUI

struct RolesView: View {
    var body: some View {
        VStack {
            Text("Roles")
            
        }
        
            List {
                Section{
                    StyledNavButton(
                        imageName: "bird",
                        text: "Fledgling",
                        destination: AnyView(Text("Beginner Detail"))
                    )
                }
                Section {
                    StyledNavButton(
                        imageName: "moonphase.waxing.crescent",
                        text: "Rapport-Builder",
                        destination: AnyView(Text("Detail"))
                    )
                }
                Section {
                    StyledNavButton(
                        imageName: "flame",
                        text: "Transcendant",
                        destination: AnyView(Text("Detail"))
                    )
                }
                    
                }
                
            }
        }

#Preview {
    RolesView()
}
