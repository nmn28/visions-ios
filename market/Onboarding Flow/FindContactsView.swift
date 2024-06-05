//
//  FindContactsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct FindContactsView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @State private var searchText = "" // State variable for search text
    @State private var contacts = [String]() // Mock data for contacts
    @State private var navigateToDiscoverUsers: Bool = false
    
    var body: some View {
        VStack {
            Image(systemName: "person.crop.rectangle.stack")
                .font(.title)
                .padding()
            
            // Search bar for finding contacts
            TextField("Search Contacts", text: $searchText)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                navigateToDiscoverUsers = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            // List of contacts (Replace with actual data)
            List {
                ForEach(filteredContacts(), id: \.self) { contact in
                    Text(contact)
                }
            }

            Text("Ideas.io")
            
            NavigationLink(destination: DiscoverUsersView(), isActive: $navigateToDiscoverUsers) {
                EmptyView()
            }
            
        }
        .navigationBarTitle("Find Contacts", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("7/10")
            }
        }
    }
    
    // Function to filter contacts based on search text
    private func filteredContacts() -> [String] {
        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
    }
}

#Preview {
    FindContactsView()
}
