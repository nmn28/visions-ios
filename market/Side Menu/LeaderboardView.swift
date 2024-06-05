//
//  LeaderboardView.swift
//  market
//
//  Created by Nicholas Nelson on 4/17/24.
//

import SwiftUI

struct LeaderboardView: View {
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                
                GroupBox(label: HStack {
                    Image(systemName: "circle.grid.2x1")
                        .imageScale(.large)
                    Text("Binary Options")
                }) {
                    VStack(alignment: .leading) {
                        Text("Most Won")
                        Text("Longest Streak")
                        Text("Highest W/L Ratio")
                        Text("Highest Single-Binary ROI")
                        Text("Most Investments")
                    }
                    .padding(.vertical, 5)
                }
                
                GroupBox(label: HStack {
                    Image(systemName: "chart.xyaxis.line")
                        .imageScale(.large)
                    Text("Stock Options")
                }) {
                    VStack(alignment: .leading) {
                        Text("Highest Single-Stock ROI")
                        Text("Most Stock Investments")
                        Text("Most Stock-Options Currently Owned")
                    }
                    .padding(.vertical, 5)
                }
                
                GroupBox(label: HStack {
                    Image(systemName: "flowchart")
                        .imageScale(.large)
                    Text("Categories")
                }) {
                    VStack(alignment: .leading) {
                        Text("Highest Category ROI")
                        Text("Most Stock Investments")
                        Text("Most Categories Currently Owned")
                    }
                    .padding(.vertical, 5)
                }
                
                GroupBox(label: HStack {
                    Image(systemName: "person.circle")
                        .imageScale(.large)
                    Text("Profiles")
                }) {
                    VStack(alignment: .leading) {
                        Text("Highest Profile ROI")
                        Text("Most Profile Investments")
                        Text("Most Profiles Currently Owned")
                    }
                    .padding(.vertical, 5)
                }
                
            }
            .padding()
        }
    }
}


#Preview {
    LeaderboardView()
}
