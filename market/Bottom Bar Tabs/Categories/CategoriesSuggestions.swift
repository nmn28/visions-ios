//
//  CategoriesSuggestions.swift
//  market
//
//  Created by Nicholas Nelson on 5/8/24.
//

import SwiftUI

struct CategoriesSuggestions: View {
    @ObservedObject private var navBarInfo = NavBarInfo.shared
    
    var body: some View {
        ScrollView {
            NavBarScrollTracker()
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 10, height: navBarInfo.height)
                
                ScrollView {
                    VStack(alignment: .leading) {
                        
                        GroupBox(label: HStack {

                            Text("More like (recently visited category)")
                        }) {
                            VStack(alignment: .leading) {
                                Text("Suggested")
                                Text("Suggested")
                                Text("Suggested")
                                Text("Suggested")
                            }
                            .padding(.vertical, 5)
                        }
                        
                        GroupBox(label: HStack {

                            Text("New")
                        }) {

                        }
                        
                        GroupBox(label: HStack {

                            Text("Volatile")
                        }) {

                        }
                        
                        GroupBox(label: HStack {

                            Text("Profiles")
                        }) {
                        }
                        
                    }
                    .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        
    }
}

#Preview {
    CategoriesSuggestions()
}
