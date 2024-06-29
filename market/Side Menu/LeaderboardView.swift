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
                    Image(systemName: "person.bust")
                        .imageScale(.large)
                    Text("Leaderboard")
                }) {
                    VStack(alignment: .leading) {
                        Text("Most Won")
                        Text("Longest Streak")
                        Text("Best W/L Ratio")
                        Text("Highest ROI")
                        Text("Most Investments")
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
