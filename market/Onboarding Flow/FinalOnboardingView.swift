//
//  FinalOnboardingView.swift
//  market
//
//  Created by Nicholas Nelson on 12/8/23.
//

import SwiftUI

struct FinalOnboardingView: View {
    var body: some View {
        VStack {
            GeometryReader { geometry in
                Image("ideas")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
//        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("10/10")
            }
        }
    }
}
#Preview {
    FinalOnboardingView()
}
