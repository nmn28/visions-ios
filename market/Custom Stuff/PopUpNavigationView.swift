//
//  PopUpNavigationView.swift
//  market
//
//  Created by Nicholas Nelson on 5/2/24.
//

import Foundation

import SwiftUI

// MARK: Task Model
struct Choice: Identifiable{
    var id = UUID().uuidString
    var choiceTitle: String
    var choiceDescription: String
}

// MARK: Sample Tasks
var choices: [Choice] = [

    Choice(choiceTitle: "Meeting", choiceDescription: "Discuss team task for the day"),
    Choice(choiceTitle: "Icon set", choiceDescription: "Edit icons for team task for next week"),
    Choice(choiceTitle: "Prototype", choiceDescription: "Make and send prototype"),
    Choice(choiceTitle: "Check asset", choiceDescription: "Start checking the assets"),
    Choice(choiceTitle: "Team party", choiceDescription: "Make fun with team mates"),
    Choice(choiceTitle: "Client Meeting", choiceDescription: "Explain project to clinet"),
    
    Choice(choiceTitle: "Next Project", choiceDescription: "Discuss next project with team"),
    Choice(choiceTitle: "App Proposal", choiceDescription: "Meet client for next App Proposal"),
]

struct PopUpNavigationView: View {
@State var showPopup: Bool = false
var body: some View {
    
    NavigationView{
        
        Button("Show Popup"){
            withAnimation{
                showPopup.toggle()
            }
        }
        .navigationTitle("Custom Popup's")
    }
    .popupNavigationView(horizontalPadding: 40, show: $showPopup) {
        
        // MARK: Your Popup content which will also performs navigations
        List{
            ForEach(choices){choice in
                NavigationLink(choice.choiceTitle) {
                    Text(choice.choiceDescription)
                        .navigationTitle("Destination")
                }
            }
        }
        .navigationTitle("Popup Navigation")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                }
            }
            
            ToolbarItem(placement: .navigationBarLeading) {
                Button("Close"){
                    withAnimation{showPopup.toggle()}
                }
            }
        }
    }
}
}


// MARK: Custom View Property Extensions
extension View {
    // MARK: Building a Custom Modifier for Custom Popup navigation View
    func popupNavigationView<Content: View>(
        horizontalPadding: CGFloat = 40,
        minPopupHeight: CGFloat = 300, // Minimum popup height
        show: Binding<Bool>,
        @ViewBuilder content: @escaping () -> Content
    ) -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .overlay {
                if show.wrappedValue {
                    GeometryReader { proxy in
                        Color.primary.opacity(0.15)
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    show.wrappedValue = false
                                }
                            }

                        let size = proxy.size
                        let calculatedHeight = max(size.height * 0.5, minPopupHeight)

                        NavigationView {
                            content()
                        }
                        .frame(width: size.width - horizontalPadding, height: calculatedHeight)
                        .cornerRadius(15)
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                    }
                }
            }
    }
}


#Preview {
    PopUpNavigationView()
}


