//
//  OnboardingView.swift
//  market
//
//  Created by Nicholas Nelson on 12/6/23.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        NavigationView {
            VStack {
                // Dynamic content based on the current step
                Group {
                    switch onboardingViewModel.currentStep {
                    case 1:
                        PhoneEmailEntryView(onboardingViewModel: onboardingViewModel)
                    case 2:
                        VerificationCodeEntryView(destination: onboardingViewModel.userEnteredDestination)
                    case 3:
                        UsernameCreationView()
                    case 4:
                        PasswordCreationView()
                    case 5:
                        NameEntryView()
                    case 6:
                        DateofBirthEntryView()
                    case 7:
                        FindContactsView()
                    case 8:
                        DiscoverUsersView()
                    case 9:
                        NotificationsEnablingView(onboardingViewModel: onboardingViewModel)
                    default:
                        Text("Unknown Step")
                    }
                }
                .transition(.slide) // Optional: Add transitions for step changes
                
                // Progress bar at the bottom
                VStack {
                    ProgressView(value: onboardingViewModel.progressFraction)
                        .progressViewStyle(LinearProgressViewStyle())
                        .scaleEffect(x: 1, y: 2, anchor: .center)
                        .padding()
                    
                    Text("\(onboardingViewModel.currentStep)/\(onboardingViewModel.totalSteps)")
                        .padding(.bottom)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Account Creation")
            
        }
    }
}
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        let onboardingViewModel = OnboardingViewModel()
        let authViewModel = AuthViewModel()
        OnboardingView(onboardingViewModel: onboardingViewModel, authViewModel: authViewModel)
    }
}
