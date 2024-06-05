//
//  MembershipView.swift
//  market
//
//  Created by Nicholas Nelson on 12/13/23.
//

import SwiftUI

struct MembershipView: View {
    var body: some View {
        VStack {
            Text("Membership")
            
        }
        
            List {
                Section{
                    StyledNavButton(
                        imageName: "leaf",
                        text: "Growth",
                        destination: AnyView(Text("Beginner Detail"))
                    )
                }
                Section {
                    StyledNavButton(
                        imageName: "lightbulb.min",
                        text: "Enlighten",
                        destination: AnyView(Text("Detail"))
                    )
                }
                Section {
                    StyledNavButton(
                        imageName: "rays",
                        text: "Transcend",
                        destination: AnyView(Text("Detail"))
                    )
                }
                    
                }
                
            }
        }
    

#Preview {
    MembershipView()
}
