//
//  aiChatMessage.swift
//  market
//
//  Created by Nicholas Nelson on 1/20/24.
//

import Foundation

struct aiChatMessage: Identifiable {
    let id = UUID()
    let message: String
    let isUser: Bool
}
