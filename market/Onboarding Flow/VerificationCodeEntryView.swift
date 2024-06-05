//
//  VerificationCodeEntryView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//


import SwiftUI

struct VerificationCodeEntryView: View {
    @State private var verificationCode: String = ""
    @State private var isCodeValid: Bool = true
    @State private var verificationSuccessful: Bool = false
    let destination: String
    @StateObject var onboardingViewModel = OnboardingViewModel()
    
    var body: some View {
        VStack {
            Image(systemName: "person.badge.shield.checkmark")
                .font(.title)
                .padding()
            
            Text("Sent to \(destination)")
                .font(.headline)
                .padding()
            
            TextField("Code", text: $verificationCode)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.numberPad)
                .padding()
            
            if !isCodeValid {
                Text("Invalid code. Please try again.")
                    .foregroundColor(.red)
            }
            
            Button("Verify") {
                // For preview purposes, consider any input as valid
                isCodeValid = true
                verificationSuccessful = true // Navigate to UsernameCreationView regardless of the code
            }
            .padding()
            .disabled(verificationCode.isEmpty)
            
            Button("Resend") {
                // Add action to resend the code
            }
            .padding()
            
            Spacer()
            Text("Ideas.io")
            // Navigation link to go to the next view when verification is successful
            NavigationLink(destination: UsernameCreationView(), isActive: $verificationSuccessful) {
                EmptyView()
            }
        }
        .navigationBarTitle("Enter Code", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("2/10")
            }
        }
    }
}



#Preview {
    VerificationCodeEntryView(destination: "+1 555-555-5555")
}
