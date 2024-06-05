//
//  DateofBirthEntryView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct DateofBirthEntryView: View {
    @State private var birthday: String = ""
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @State private var navigateToFindContacts: Bool = false
    var body: some View {
        VStack {
            Image(systemName: "birthday.cake")
                .font(.title)
                .padding()
            
            TextField("MM/DD/YY", text: $birthday)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            
            
            Button(action: {
                navigateToFindContacts = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            .disabled(birthday.isEmpty)  // Disable the button if no name is entered
            
            
            Text("Why must I provide this?")
                .padding()
            Spacer()
            Text("Ideas.io")
            
            NavigationLink(destination: FindContactsView(), isActive: $navigateToFindContacts) {
                EmptyView()
            }
        }
        .navigationBarTitle("Birthdate", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("6/10")
            }
        }
    }
}
#Preview {
    DateofBirthEntryView()
}
