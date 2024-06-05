//
//  MessagesView.swift
//  market
//
//  Created by Nicholas Nelson on 12/12/23.
//

import SwiftUI

struct UserWithLastMessage: Identifiable {
    var id: UUID { user.id } // Use the `id` of the `User`
    let user: User
    let lastMessage: String
    let lastMessageTime: String
}

let sampleUsers = [
    UserWithLastMessage(user: User.stub, lastMessage: "Hey, how are you?", lastMessageTime: "10:30 AM"),
    // Add more sample users as needed
]

struct MessagesView: View {
    var body: some View {
        NavigationView {
            VStack {
               
//                    Image(systemName: "lock.shield")
                    Button("End-to End-Encrypted") {
                    
                    }
                        .font(.subheadline)
                        .padding(.vertical, 4)
                        
                
//                               Button("Archived") {
//                                   // Action for button
//                               }
//                               .frame(maxWidth: .infinity, alignment: .leading)
//                               .padding()
//                               .background(Color.white)
                List(sampleUsers) { userWithLastMessage in
                    NavigationLink(destination: ChatView()) {
                        HStack {
                            UserImage(imageName: userWithLastMessage.user.imageName, isOnline: userWithLastMessage.user.isOnline, size: 55)
                            MessagePreviewView(userWithLastMessage: userWithLastMessage)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .navigationBarTitle("Messages")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarLeading) {
                        Button(action: {
                            // Add action for menu card
                        }) {
                            Image(systemName: "ellipsis.circle")
                        }

                        Button(action: {
                            // Add action for magnifying glass
                        }) {
                            Image(systemName: "plus.circle.fill")
                        }
                        
                                            }
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        Button(action: {
                            // Add action for magnifying glass
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                        
                        Button(action: {
                            // Add action for menu card
                        }) {
                            Image(systemName: "menucard")
                        }
                    }
                }
            }
        }
    }
}

struct MessagePreviewView: View {
    var userWithLastMessage: UserWithLastMessage
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(userWithLastMessage.user.name) // Display user's name
                    .fontWeight(.semibold)
                    .padding(.horizontal)
                Spacer()
                Text(userWithLastMessage.lastMessageTime)
                    .font(.caption)
                    .foregroundColor(.gray)
                    
            }
            Text(userWithLastMessage.lastMessage)
                .lineLimit(1)
                .foregroundColor(.gray)
                .padding(.horizontal)
                .font(.subheadline)
        }
    }
}
struct MessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MessagesView()
    }
}
