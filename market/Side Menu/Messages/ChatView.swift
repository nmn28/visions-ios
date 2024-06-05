//
//  ChatView.swift
//  market
//
//  Created by Nicholas Nelson on 2/1/24.
//

import SwiftUI

// Message model
struct Message: Identifiable {
    let id = UUID()
    let text: String
    let isCurrentUser: Bool
}

// Chat View
struct ChatView: View {
    @State private var messageText: String = ""
    @State private var messages: [Message] = []
    @State private var username: String = "User Name"
    @State private var imageName: String = "defaultImageName" // Replace with actual image name
        @State private var isOnline: Bool = true

    var body: some View {
        VStack {
            Text("End-to-End Encrypted")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color.white)
            ScrollView {
                ScrollViewReader { scrollView in
                    ForEach(messages) { message in
                        HStack {
                            if message.isCurrentUser {
                                Spacer()
                                Text(message.text)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                            } else {
                                Text(message.text)
                                    .padding()
                                    .background(Color.gray)
                                    .foregroundColor(Color.white)
                                    .cornerRadius(10)
                                Spacer()
                            }
                        }
                        .padding()
                    }
                    .onChange(of: messages.count) { _ in
                        scrollView.scrollTo(messages.last?.id)
                    }
                }
            }

            HStack {
                Menu {
                    
                    Button(action: { /* Action for Menu Item 1 */ }) {
                        Label("Poll", systemImage: "checklist") // Replace with your desired SF Symbol
                    }
                    Button(action: { /* Action for Menu Item 1 */ }) {
                        Label("File", systemImage: "folder") // Replace with your desired SF Symbol
                    }
                    Button(action: { /* Action for Menu Item 1 */ }) {
                        Label("Photo/Video Library", systemImage: "photo") // Replace with your desired SF Symbol
                    }
                    Button(action: { /* Action for Menu Item 1 */ }) {
                        Label("Camera", systemImage: "camera") // Replace with your desired SF Symbol
                    }
                    
                    
                } label: {
                    // Your existing icon code
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 24, height: 24)
                    //                        .foregroundColor(AppColors.gray)
                }
                TextField("Message...", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(minHeight: CGFloat(30))

                Button(action: sendMessage) {
                    Text("Send")
                }
            }
            .padding()
//            .frame(minHeight: CGFloat(50)).padding()
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .principal) {
                            HStack {
                                UserImage(imageName: imageName, isOnline: isOnline, size: 40) // Your user image view
//                                    .frame(width: 30, height: 30)
//                                    .clipShape(Circle())

                                Text(username) // Display the username
                                    .font(.headline)
                            }
                        }
                    }
        
    }

    func sendMessage() {
        guard !messageText.isEmpty else { return }
        // For demo purposes, we're marking even messages as from the current user
        let newMessage = Message(text: messageText, isCurrentUser: (messages.count % 2 == 0))
        messages.append(newMessage)
        messageText = ""
    }
}

// Preview
struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
