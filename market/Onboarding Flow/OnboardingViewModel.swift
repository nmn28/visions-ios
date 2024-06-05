//
//  OnboardingViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 12/6/23.
//

import Foundation

class OnboardingViewModel: ObservableObject {
    let totalSteps = 8  // Make this property internal (default) or public
    @Published var currentStep = 1
    @Published var userEnteredDestination: String = ""
    // Function to advance to the next step
    func advanceToNextStep() {
        if currentStep < totalSteps {
            currentStep += 1
        }
    }
    
    // Function to reset or go back to a specific step, if needed
    func goToStep(_ step: Int) {
        if step >= 1 && step <= totalSteps {
            currentStep = step
        }
    }
    
    // Computed property to represent the progress in a format suitable for ProgressView
    var progressFraction: Double {
        Double(currentStep) / Double(totalSteps)
    }
}
