//
//  StockViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 5/3/24.
//

import Foundation
import SwiftUI

struct Stock: Identifiable {
    let id = UUID()
    let name: String
    let username: String
    let title: String
    let body: String
    let stockMedia: StockMediaType?
    let priceChange: String
    let priceChangePercentage: String
    // Include other properties as needed
}

// Enum for media type
enum StockMediaType {
    case photo(Image)
    case video(URL)
    case document(URL)
    // ... add other types as needed
}

@MainActor
class StockViewModel: ObservableObject {
    
    @Published var stocks: [Stock] = []
    
    // Initialize with sample data for testing
    init() {
        
        stocks = [
            Stock(
                name: "Jane Doe",
                username: "@jane_doe",
                title: "Feudalism will be big in the future as AI automates our lives",
                body: "Retiring to a farm might be most appealing given the state of food and our ability to automate with singularity",
                stockMedia: .photo(Image("sampleImage")),
                priceChange: "+$2.50",
                priceChangePercentage: "+1.25%"
            ),
            // ... add more sample data if needed
        ]
    }
}
