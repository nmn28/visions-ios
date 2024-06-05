//
//  BinaryViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 1/18/24.
//

import Foundation
import SwiftUI

struct Binary: Identifiable, Hashable {
    
    
    let id = UUID()
    let name: String
    let username: String
    let title: String
    let body: String
    let media: MediaType?
    let priceChange: String
    let priceChangePercentage: String
    // Include other properties as needed
    
    func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
        
        // Equatable conformance if needed
        static func == (lhs: Binary, rhs: Binary) -> Bool {
            return lhs.id == rhs.id
        }
    }


// Enum for media type
enum MediaType {
    case photo(Image)
    case video(URL)
    case document(URL)
    // ... add other types as needed
}

@MainActor
class BinaryViewModel: ObservableObject {
    
    @Published var binaries: [Binary] = []
    
    // Initialize with sample data for testing
    init() {
        
        binaries = [
            Binary(
                name: "Jane Doe",
                username: "@jane_doe",
                title: "Ai Will Be President",
                body: "We are approaching GPT 5, and it is supposed to be expontentially better than the last model.",
                media: .photo(Image("sampleImage")),
                priceChange: "+$2.50",
                priceChangePercentage: "+1.25%"
            ),
            // ... add more sample data if needed
        ]
    }
}
