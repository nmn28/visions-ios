//
//  NameEntryView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct NameEntryView: View {
    @State private var fullName: String = ""
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @State private var navigateToDateofBirth: Bool = false
    var body: some View {
        VStack {
            Image(systemName: "person.text.rectangle")
                .font(.title)
                .padding()

            TextField("Full Name", text: $fullName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                navigateToDateofBirth = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            .disabled(fullName.isEmpty)  // Disable the button if no password is entered
            
            Spacer()
            Text("Ideas.io")
            
            NavigationLink(destination: DateofBirthEntryView(), isActive: $navigateToDateofBirth) {
                EmptyView()
            }
        }
        .navigationBarTitle("Your Name", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("5/10")
            }
        }
    }
}

#Preview {
    NameEntryView()
}
