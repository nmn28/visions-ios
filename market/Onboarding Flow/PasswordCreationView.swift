//
//  PasswordCreationView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct PasswordCreationView: View {
    @State private var password: String = ""
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @State private var navigateToNameEntry: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "lock.app.dashed")
                .font(.title)
                .padding()
            
            SecureField("Password", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            PasswordRequirementsView(password: password)
            
            Button(action: {
                navigateToNameEntry = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            .disabled(password.isEmpty)  // Disable the button if no password is entered
            
            Spacer()
            Text("Ideas.io")
            
            NavigationLink(destination: NameEntryView(), isActive: $navigateToNameEntry) {
                EmptyView()
            }
        }
        .navigationBarTitle("Password", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("4/10")
            }
        }
        
    }
}

struct PasswordRequirementsView: View {
    let password: String
    let requirements = [
        "Minimum 10 characters",
        "1 capital letter",
        "1 special characters"
    ]
    
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(requirements, id: \.self) { requirement in
                HStack {
                    Text("• \(requirement)")
                        .foregroundColor(.gray)
                    
                    Spacer()
                    
                    // Check if the requirement is met and show the appropriate icon
                    Image(systemName: isRequirementMet(requirement) ? "checkmark.circle" : "xmark.circle")
                        .foregroundColor(isRequirementMet(requirement) ? .green : .red)
                }
            }
        }
        .padding(.horizontal)
    }
    
    // Function to check if a requirement is met
    private func isRequirementMet(_ requirement: String) -> Bool {
        switch requirement {
        case "Minimum 10 characters":
            return password.count >= 10
        case "1 capital letter":
            return password.range(of: "[A-Z]", options: .regularExpression) != nil
        case "1 special characters":
            let specialCharPattern = "[!@#$%^&*(),.?\":{}|<>]"
            let matches = password.components(separatedBy: CharacterSet(charactersIn: specialCharPattern)).count - 1
            return matches >= 1
        default:
            return false
        }
    }
}

#Preview {
    PasswordCreationView()
}
