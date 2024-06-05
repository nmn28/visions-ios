//
//  RegistrationViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import Foundation

class RegistrationViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var showAlert = false
    @Published var alertMessage = ""

    func register() {
        let credentials = Credentials(username: username, password: password)
        NetworkManager.shared.register(credentials: credentials) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let user):
                    AuthenticationManager.shared.saveToken(user.token)
                    // Navigate to the main content of your app
                case .failure(let error):
                    self.alertMessage = error.localizedDescription
                    self.showAlert = true
                    // Show alert to the user with the error message
                }
            }
        }
    }
}
