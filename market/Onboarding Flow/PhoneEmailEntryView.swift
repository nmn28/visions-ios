//
//  PhoneEmailEntryView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct PhoneEmailEntryView: View {
    @State private var selectedTab = 0  // Index for selected tab
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    
    enum TabContent {
        case text(String)
        // Add other cases as needed, for example, icons or custom views
    }
    
    private let tabs: [TabContent] = [
        .text("Phone"),  // Tab for phone entry
        .text("Email")   // Tab for email entry
    ]

    var body: some View {
//        VStack {
//            CustomPickerView(selectedTab: $selectedTab, tabs: tabs) { index in
//                // Ensure each case returns a View
//                Group {
//                    switch index {
//                    case 0:
//                        PhoneEntryView(onboardingViewModel: onboardingViewModel)
//                    case 1:
//                        EmailEntryView(onboardingViewModel: onboardingViewModel)
//                    default:
//                        Text("Unknown Tab") // Default case to handle unexpected indexes
//                    }
//                }
//            }
//            .padding(.bottom)

            Text("Ideas.io")
                .padding()
        }
//        .navigationBarTitle("Receive Code", displayMode: .inline)
//        .toolbar {
//            ToolbarItem(placement: .navigationBarTrailing) {
//                Text("1/10")
//            }
//        }
    }
//}

struct PhoneEntryView: View {
    @State private var phoneNumber: String = ""
    @State private var navigateToVerification = false
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "phone")
                .font(.title)
                .padding()
            
            TextField("Phone Number", text: $phoneNumber)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding()
            
            Button(action: {
                navigateToVerification = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .disabled(phoneNumber.isEmpty)
            .padding()
            
            Spacer()
            
            NavigationLink("", destination: VerificationCodeEntryView(destination: phoneNumber), isActive: $navigateToVerification)
                .hidden()
            Spacer()
            
            
        }
        .padding()
    }
}

struct EmailEntryView: View {
    @State private var email: String = ""
    @State private var navigateToVerification = false
    @ObservedObject var onboardingViewModel: OnboardingViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "envelope")
                .font(.title)
                .padding()
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .keyboardType(.phonePad)
                .padding()
            
            Button(action: {
                navigateToVerification = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .disabled(email.isEmpty)
            .padding()
            
            Spacer()
            
            NavigationLink("", destination: VerificationCodeEntryView(destination: email), isActive: $navigateToVerification)
                .hidden()
            Spacer()
            
            
        }
        .padding()
    }
}


class PhoneEmailEntryViewModel: ObservableObject {
    // Function to send a verification code and store phone/email in the database
    func storeDataAndSendVerificationCode(to destination: String, isPhone: Bool) {
        // Endpoint for storing contact information
        let storeEndpoint = "storeContactInfo"
        
        // Endpoint for sending verification code
        let verifyEndpoint = isPhone ? "sendCodeToPhone" : "sendCodeToEmail"
        
        // Combine URLs
        let storeUrlString = "https://yourbackend.com/\(storeEndpoint)"
        let verifyUrlString = "https://yourbackend.com/\(verifyEndpoint)"
        
        // Prepare data to be sent
        let body: [String: String] = ["contact": destination]
        
        // First, store the contact information
        postRequest(to: storeUrlString, body: body) { success in
            if success {
                // If storing is successful, send the verification code
                self.postRequest(to: verifyUrlString, body: body) { _ in
                    // Handle sending verification code (success or failure)
                }
            } else {
                // Handle failure to store contact information
            }
        }
    }
    
    // Helper function to make a POST request
    private func postRequest(to urlString: String, body: [String: String], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            completion(false)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // Assume success if status code is 200
                completion(true)
            } else {
                completion(false)
            }
        }
        task.resume()
    }
}

struct PhoneEmailEntryView_Previews: PreviewProvider {
    static var previews: some View {
        let onboardingViewModel = OnboardingViewModel()
        PhoneEmailEntryView(onboardingViewModel: OnboardingViewModel())
    }
}
