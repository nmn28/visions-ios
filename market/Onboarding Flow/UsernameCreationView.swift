//
//  UsernameCreationView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct UsernameCreationView: View {
    @State private var username: String = ""
    @State private var isUsernameAvailable: Bool? = nil // nil when not checked, true if available, false if not
    @State private var navigateToPasswordCreation: Bool = false // New state variable
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "at")
                .font(.title)
                .padding()
            
            HStack {
                TextField("@", text: $username)
                    .onChange(of: username) { _ in checkUsernameAvailability() }
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Showing checkmark or X based on availability
                if let isAvailable = isUsernameAvailable {
                    Image(systemName: isAvailable ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(isAvailable ? .green : .red)
                }
            }
            .padding()
            
            Button(action: {
                navigateToPasswordCreation = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            .disabled(username.isEmpty)
            
            Spacer()
            Text("Ideas.io")
            
            // Navigation link to go to the password creation view
            NavigationLink(destination: PasswordCreationView(), isActive: $navigateToPasswordCreation) {
                EmptyView()
            }
            
        }
        .navigationBarTitle("Username", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("3/10")
            }
        }
    }
    
    // Function to check username availability
    private func checkUsernameAvailability() {
        // Call your backend service to check username availability
        // For now, this is a mock function
        // Replace this with a real network request
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // Mock delay
            // Assume username "user123" is taken as an example
            self.isUsernameAvailable = self.username != "user123"
        }
    }
}
#Preview {
    UsernameCreationView()
}
