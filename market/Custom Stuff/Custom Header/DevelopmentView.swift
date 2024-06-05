//
//  DevelopmentView.swift
//  market
//
//  Created by Nicholas Nelson on 5/7/24.
//

import Foundation
import SwiftUI

struct DevelopmentView: View {
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
                        .fill(Color.orange)
                        .frame(width: 100, height: 50)
                        .padding()
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
        .background(.purple)
    }
}

struct DevelopmentView_Previews: PreviewProvider {
    static var previews: some View {
        DevelopmentView()
            
    }
}
