//
//  SafetyView.swift
//  market
//
//  Created by Nicholas Nelson on 12/12/23.
//

import SwiftUI

struct SafetyView: View {
    var body: some View {

            List {
                Section{
                    StyledNavButton(
                        imageName: "lock",
                        text: "Privacy",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "building.columns",
                        text: "Financing",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "doc.text",
                        text: "Terms",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                }
                
            }
        }
    }


#Preview {
    SafetyView()
}
