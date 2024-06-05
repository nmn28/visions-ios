//
//  InstructionsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/25/23.
//

import SwiftUI

struct InstructionsView: View {
    var body: some View {
        VStack {
            //            CustomDivider()
            InstructionsCustomToolbar()
            List {
                Section{
                    
                    StyledNavButton(
                        imageName: "eye",
                        text: "Watchlists",
                        destination: AnyView(WatchlistsInstructionsView())
                    )
                    
                    
                    
                    StyledNavButton(
                        imageName: "flowchart",
                        text: "Categories",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "briefcase",
                        text: "Finances",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "wand.and.stars",
                        text: ".ai",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "safari",
                        text: "Explore",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                } header: {
                    
                    Text("Main Tabs")
                } footer: {
                    
                    Text("These are the main tabs you will use.")
                }
                     
                Section{
                    
                    StyledNavButton(
                        imageName: "person.bust",
                        text: "Leaderboard",
                        destination: AnyView(Text("Walkthrough Detail"))
                    )
                    
                    StyledNavButton(
                        imageName: "map",
                        text: "Map",
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
                    
                    Text("Features")
                } footer: {
                    
                    Text("Dont miss out on these areas. Further insight and data can only enhance your experience.")
                }
                
            }
//            .padding(.top,-8)
//            .padding(.bottom)
            
        }
    }
}

struct InstructionsCustomToolbar: View {
//    @Binding var isOpened: Bool
    
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(VStack(alignment: .leading, spacing: -4) {
                    Text("Forecast.ai")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                    Text("date")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                })
            },
            centerContent: {
                AnyView(Text("Instructions").font(.headline))
            },
            rightContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
//                        isOpened.toggle()
                    }) {
                        Image(systemName: "menucard")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                })
            }
        )
    }
}

#Preview {
    InstructionsView()
}
