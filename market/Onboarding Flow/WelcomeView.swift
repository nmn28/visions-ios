//
//  WelcomeView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showTitle = false
    @State private var raiseTitle = false
    @State private var showButtons = false
    @ObservedObject var authViewModel: AuthViewModel
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                if showTitle {
                    Image(systemName: "rays")
                        .font(.largeTitle)
                    Text("Forecast.ai")
                        .font(.largeTitle)
                        .padding(.bottom)
                }
                
                if showButtons {
                    HStack {
                        NavigationLink(destination: PhoneEmailEntryView(onboardingViewModel: onboardingViewModel)) {
                            Image(systemName: "person.badge.plus")
                                .font(.title)
                        }
                        .padding(.horizontal)
                        
                        Text("/")
                            .font(.title)
                        
                        NavigationLink(destination: LoginView(authViewModel: authViewModel)) {
                            Image(systemName: "door.left.hand.open")
                                .font(.title)
                        }
                        .padding(.horizontal)
                    }
                    .opacity(showButtons ? 1 : 0)  // Fade in the buttons
                    .offset(y: showButtons ? 0 : 50)  // Drop down the buttons
                    
                }
            }
            .onAppear {
                withAnimation(.easeInOut(duration: 1)) {
                    showTitle = true
                }
                withAnimation(.easeInOut(duration: 0.5).delay(0.5)) {
                    raiseTitle = true
                }
                withAnimation(.easeInOut(duration: 0.5).delay(1)) {
                    showButtons = true
                }
            }
        }
    }
}


struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        let authViewModel = AuthViewModel()
        let onboardingViewModel = OnboardingViewModel()
        WelcomeView(authViewModel: authViewModel, onboardingViewModel: onboardingViewModel)
    }
}
