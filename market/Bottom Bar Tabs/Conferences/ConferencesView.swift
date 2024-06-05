//
//  ConferencesView.swift
//  market
//
//  Created by Nicholas Nelson on 1/9/24.
//

import SwiftUI

struct ConferencesView: View {
    @Binding var isOpened: Bool
    var body: some View {
        VStack {
            ConferencesCustomToolbar(isOpened: $isOpened)
            
            HStack() {
                Spacer()
                Text("My Conferences")
                Spacer()
                Text("Create a Conference")
                Spacer()
            }
            .padding(.horizontal)
            .padding(.vertical, 8)
            
            Spacer()
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
        
        
        
    }
    
}

struct ConferencesCustomToolbar: View {
    @Binding var isOpened: Bool
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
                        
                    }) {
                        Image(systemName: "plus.circle")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {

                        
                    }) {
                        Image(systemName: "questionmark")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                })
            },
            centerContent: {
                AnyView(Text("Conferences").font(.headline))
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
                        isOpened.toggle()
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
struct ConferencesView_Previews: PreviewProvider {

    @State static var isOpened = false
    static var previews: some View {
        ConferencesView(isOpened: $isOpened)
    }
}
