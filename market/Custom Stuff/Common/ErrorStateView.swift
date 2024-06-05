//
//  ErrorStateView.swift
//  market
//
//  Created by Nicholas Nelson on 11/25/23.
//

import SwiftUI

struct ErrorStateView: View {
    
    let error: String
    var retryCallback: (() -> ())? = nil
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 16) {
                Text(error)
                if let retryCallback {
                    Button("Retry", action: retryCallback)
                        .buttonStyle(.borderedProminent)
                }
                
            }
            Spacer()
        }
        .padding(64)
    }
}

struct ErrorStateView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ErrorStateView(error: "An Error Ocurred") {}
                .previewDisplayName("With Retry Button")
            
            ErrorStateView(error: "An Error Ocurred")
                .previewDisplayName("Without Retry Button")
        }
    }
}
