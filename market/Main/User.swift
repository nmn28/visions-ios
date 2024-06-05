//
//  User.swift
//  market
//
//  Created by Nicholas Nelson on 12/5/23.
//

import Foundation

enum UserRole: String, Codable {
    case investor
    case creator
    case viewer
}

struct UserSettings: Codable {
    var preferredLanguage: String = "English"
    var notificationsEnabled: Bool = true
}

struct User: Identifiable, Codable {
    var id = UUID()
    var roles: [UserRole]
    var settings: UserSettings = UserSettings() // Default settings
    var username: String
    var token: String
    var name: String
    var bio: String
    var position: String
    var imageName: String
    var isOnline: Bool
}

extension User {
    static let stub = User(
        roles: [.investor],
        settings: UserSettings(preferredLanguage: "English", notificationsEnabled: true),
        username: "JaneDoe",
        token: "99443",
        name: "Jane Doe",
        bio: "Hi",
        position: "CTO",
        imageName: "placeholder/user",
        isOnline: true
    )
}

extension User {
    static let alice = User(
        roles: [.creator], // Assuming Alice is a creator
        settings: UserSettings(preferredLanguage: "English", notificationsEnabled: true),
        username: "Alice",
        token: "token123",
        name: "Alice Johnson",
        bio: "Entrepreneur",
        position: "CEO",
        imageName: "aliceImage",
        isOnline: true
    )

    static let bob = User(
        roles: [.investor], // Assuming Bob is an investor
        settings: UserSettings(preferredLanguage: "English", notificationsEnabled: false),
        username: "Bob",
        token: "token456",
        name: "Bob Smith",
        bio: "Investor",
        position: "CFO",
        imageName: "bobImage",
        isOnline: false
    )

    static let charlie = User(
        roles: [.viewer], // Assuming Charlie is a viewer
        settings: UserSettings(preferredLanguage: "Spanish", notificationsEnabled: true),
        username: "Charlie",
        token: "token789",
        name: "Charlie Lee",
        bio: "BioTech Specialist",
        position: "Scientist",
        imageName: "charlieImage",
        isOnline: true
    )
}
