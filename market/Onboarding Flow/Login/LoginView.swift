//
//  LoginView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel = LoginViewModel()
    @State private var showingRegistration = false // State to control the registration view presentation
    @StateObject var forgotPasswordViewModel = ForgotPasswordViewModel()
    @State private var showingForgotPassword = false
    @ObservedObject var authViewModel: AuthViewModel

    var body: some View {
        VStack {
            TextField("Username", text: $viewModel.username)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            SecureField("Password", text: $viewModel.password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            HStack {
                Button(action: {
                    viewModel.login()
                }) {
                    Image(systemName: "door.left.hand.open")
                        .imageScale(.large)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Error"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
            }
            
            Button("Forgot Password") {
                            showingForgotPassword.toggle()
                        }
                .padding(.vertical, 10)
            
            Spacer()
        }
        .navigationTitle("Log In")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        // Create an instance of AuthViewModel for the preview
        let authViewModel = AuthViewModel()
        LoginView(authViewModel: authViewModel)
    }
}
