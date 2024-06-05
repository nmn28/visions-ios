//
//  AuthViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI
import Combine

class AuthViewModel: ObservableObject {
    @Published var isAuthenticated = false

    // Assuming you store a token or similar credential upon successful login
    private var token: String? {
        didSet {
            isAuthenticated = token != nil
        }
    }
    private var cancellables: Set<AnyCancellable> = []

    init() {
        // Check if the user is already authenticated (e.g., check for a valid token)
        loadAuthenticationStatus()
    }

    private func loadAuthenticationStatus() {
        // Here you would load the saved authentication token, if any
        // For simplicity, let's assume you're using UserDefaults
        token = UserDefaults.standard.string(forKey: "authToken")
    }

    func login(username: String, password: String) {
        // Perform login with the provided credentials
        // This is a placeholder for your actual login logic

        // Assume login is successful and a token is returned
        let receivedToken = "userToken123"
        UserDefaults.standard.set(receivedToken, forKey: "authToken")
        token = receivedToken

        // Here, after successful login, update the `isAuthenticated` state
    }

    func register(username: String, password: String) {
        // Perform registration
        // Similar to login, this is a placeholder for your actual registration logic

        // Assume registration is successful
        // You might automatically log the user in after registration
        login(username: username, password: password)
    }

    func logout() {
        // Perform logout
        UserDefaults.standard.removeObject(forKey: "authToken")
        token = nil

        // Here, update the `isAuthenticated` state to false
    }
}
