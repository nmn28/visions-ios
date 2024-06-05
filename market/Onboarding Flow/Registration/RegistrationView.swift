//
//  RegistrationView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()

    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            Button("Register", action: viewModel.register)
        }
        // Add navigation logic based on registration status
        // Add alert for error handling
    }
}
#Preview {
    RegistrationView()
}
