//
//  RootView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct RootView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        if authViewModel.isAuthenticated {
            ContentView()
                .environmentObject(MainViewModel())
        } else {
            WelcomeView(authViewModel: authViewModel, onboardingViewModel: onboardingViewModel)
        }
    }
}


#Preview {
    RootView()
}
