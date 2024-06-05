//
//  EventsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/13/23.
//

import SwiftUI

struct EventsView: View {
    var body: some View {
        NavigationView {
            Text("Trending")
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarLeading) {
                Button(action: {
//                    ExploreView()
                    
                }) {
                    Image(systemName: "plus.circle")
                }
                Button(action: {
//                    ExploreView()
                    
                }) {
                    Image(systemName: "magnifyingglass")
                }
            }
        }
//        .searchable()
    }
}

#Preview {
    EventsView()
}
