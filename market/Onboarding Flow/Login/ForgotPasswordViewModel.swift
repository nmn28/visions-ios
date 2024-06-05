//
//  ForgotPasswordViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var showAlert = false
    @Published var alertMessage = "If an account exists for this email, we have sent a reset link."

    func forgotPassword() {
        NetworkManager.shared.requestPasswordReset(email: email) { result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    // Show a confirmation message to the user
                    self.showAlert = true
                case .failure(let error):
                    // Handle errors, e.g., show an error message
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                }
            }
        }
    }
}
