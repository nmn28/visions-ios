//
//  NotificationsEnablingView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct NotificationsEnablingView: View {
    @State private var notificationsEnabled = false
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "bell.and.waves.left.and.right")
                .font(.title)
                .padding()
            
            Toggle(isOn: $notificationsEnabled) {
                Text(notificationsEnabled ? "Enabled" : "Disabled") // This is optional
            }
            .labelsHidden()
            .padding()
            
            Spacer()
            Text("Ideas.io")
        }
        .navigationTitle("Enable Notifications")
        .navigationBarTitleDisplayMode(.inline)
        .padding()
        .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Text("10/10")
                    }
                }
    }
}

#Preview {
    NotificationsEnablingView()
}
