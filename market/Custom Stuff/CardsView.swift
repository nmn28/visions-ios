//
//  CardsView.swift
//  market
//
//  Created by Nicholas Nelson on 2/9/24.
//

import SwiftUI

struct CardsView: View {
    var body: some View {
//        VStack {
            ForEach(0..<50) { item in
                Text("Item \(item)")
                    .frame(width: 300, height: 100)
                    .background(Color.blue)
                    .cornerRadius(10)
//            }
        }
    }
}

#Preview {
    CardsView()
}
