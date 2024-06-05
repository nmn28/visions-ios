//
//  aiSideMenuView.swift
//  market
//
//  Created by Nicholas Nelson on 1/20/24.
//

import SwiftUI

struct aiSideMenuView: View {
    @Binding var isShowingAiSideMenu: Bool
        // Add other properties if needed to display conversation history
    @Binding var selectedAiTab: Int
    @State private var searchText = ""
    @State private var selectedSegment = 0
    
        var body: some View {
            ZStack {
                // Dim background
                if isShowingAiSideMenu {
                    Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        isShowingAiSideMenu.toggle()
                    }
                }
                HStack {
                    // Side menu content
                    VStack(alignment: .leading, spacing: 15) {
                        HStack {
                            Spacer()
                            Text("Forecast.ai")
                            Spacer()
                        }
                        Picker("Options", selection: $selectedSegment) {
                                        Image(systemName: "text.bubble").tag(0)
                            Image(systemName: "gear").tag(1)
                                    }
                                    .pickerStyle(SegmentedPickerStyle())
                        // Add your conversation history items here
                       
//                        .padding(.vertical, 10)
                        
//                        aiCustomPicker(
//                            selectedAiTab: $selectedAiTab,
//                            tabs: [
//                                .symbol("text.bubble"),
//                                .symbol("magnifyingglass"),
//                                .symbol("gear")
//                                
//                            ],
//                            contentBuilders: [
//                                { _ in AnyView(conversationsview().frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
//                                { _ in AnyView( CustomSearchBar(text: $searchText, onSearchChanged: { newText in
//                                    // Define what happens when the search text changes in this particular view
//                                    print("Search text changed to: \(newText)")
//                                    // Add your search logic here
//                                }).frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
//                                { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) }
//                                
//                                // Add more content builders for each tab as needed
//                            ])
                        
                        if selectedSegment == 0 {
                                       ConversationsView()
                                   } else {
                                       aisettingsview()
                                   }
                        
                        
                    }
                    .padding(.horizontal)
                    .frame(width: 310)
                    .frame(maxHeight: .infinity)
                    .background(Color.white)
//                    .offset(x: isShowing ? 0 : -270) // Slide in from left
//                     isShowing)
                    
                    Spacer()
                }
            }
            .transition(.move(edge: .leading))
            .animation(.easeInOut(duration: 0.3), value: isShowingAiSideMenu)
        }
}

struct ConversationsView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Task Generation")
            
            Text("Solaris 1")
            Text("ImageGen")
            Text("Clones")
            Text("Discover Transformers and Algorithms")
            
            Divider()
            //                                    .padding(.top, 20)
            
            Text("Conversation 2")
            // ... add more as needed
            
            
            
            Spacer()
        }
    }
}

struct aisettingsview: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("Instruction")
            
            
            
            Spacer()
        }
    }
}

struct aiSideMenuView_Previews: PreviewProvider {
        @State static var isShowingAiSideMenu = true
    @State static var selectedAiTab = 0
        static var previews: some View {
            aiSideMenuView(isShowingAiSideMenu: $isShowingAiSideMenu, selectedAiTab: $selectedAiTab)
        }
    }
    
