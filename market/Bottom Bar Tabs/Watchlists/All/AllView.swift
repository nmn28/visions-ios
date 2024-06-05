//
//  AllView.swift
//  market
//
//  Created by Nicholas Nelson on 5/8/24.
//

import SwiftUI

struct AllView: View {
    @ObservedObject private var navBarInfo = NavBarInfo.shared
    
    var body: some View {
        ScrollView {
            NavBarScrollTracker()
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 10, height: navBarInfo.height)
                
                ForEach(0..<30, id: \.self) { index in
                    Circle()
                        .fill(Color.black)
                        .frame(width: 100, height: 50)
                        .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .background(.red)
    }
}
#Preview {
    AllView()
}
