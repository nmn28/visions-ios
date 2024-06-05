//
//  DiscoverPeopleView.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import SwiftUI

struct DiscoverUsersView: View {
    @StateObject var onboardingViewModel = OnboardingViewModel()
    @State private var users = [User]() // Array of users
    @State private var navigateToNotificationsEnabling: Bool = false
    var body: some View {
        VStack {
            Image(systemName: "doc.text.magnifyingglass")
                .font(.largeTitle)
                .padding()
            
            List(users, id: \.username) { user in
                HStack {
                    // Replace with actual user image
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading) {
                        Text(user.username)
                            .font(.headline)
                        Text("Bio or description here") // Placeholder for bio
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    
                    Spacer()
                    
                    // Follow button
                    Button(action: {
                        // Implement follow action
                    }) {
                        Text("Follow")
                            .foregroundColor(.blue)
                    }
                }
            }
            .listStyle(PlainListStyle())
            
            Button(action: {
                navigateToNotificationsEnabling = true
            }) {
                Image(systemName: "arrow.right")
                    .font(.title)
                
            }
            .padding()
            NavigationLink(destination: NotificationsEnablingView(), isActive: $navigateToNotificationsEnabling) {
                EmptyView()
            }
            
            Spacer()
            
            Text("Ideas.io")
            
        }
        .onAppear {
            loadUsers() // Load users when the view appears
        }
        .navigationBarTitle("Discover People", displayMode: .inline)
        .padding()
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Text("7/10")
            }
        }
    }
    
    // Function to load users (mockup function for now)
    private func loadUsers() {
        // Define user settings which will be common to all users, if applicable
        let defaultSettings = UserSettings(preferredLanguage: "English", notificationsEnabled: true)
        
        // Update User instances to include roles and settings
        self.users = [
            User(
                roles: [.viewer], // Assuming Alice is a viewer
                settings: defaultSettings,
                username: "AliceS",
                token: "token1",
                name: "Alice Smith",
                bio: "Lover of nature and art.",
                position: "Designer",
                imageName: "aliceImage",
                isOnline: true
            ),
            User(
                roles: [.investor], // Assuming Bob is an investor
                settings: defaultSettings,
                username: "BobJ",
                token: "token2",
                name: "Bob Johnson",
                bio: "Tech enthusiast and blogger.",
                position: "Engineer",
                imageName: "bobImage",
                isOnline: false
            )
            // Add more mock users here...
        ]
    }
}

#Preview {
    DiscoverUsersView()
}
