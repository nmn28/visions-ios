//
//  SheetView.swift
//  market
//
//  Created by Nicholas Nelson on 4/15/24.
//

import SwiftUI

struct SheetView: View {
    @State private var showSettings = false


        var body: some View {
            Button("View Settings") {
                showSettings = true
            }
            .sheet(isPresented: $showSettings) {
                SettingsView()
                    .presentationDetents([.medium, .large])
            }
        }
    }
#Preview {
    SheetView()
}
