//
//  IdeaQuoteViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 11/25/23.
//

import Foundation
import SwiftUI

@MainActor
class IdeaQuoteViewModel: ObservableObject {
    
    @Published var phase = FetchPhase<Quote>.initial
    var quote: Quote? { phase.value }
    var error: Error? { phase.error }
    
    let idea: Idea
    let stocksAPI: StocksAPI
    
    init(idea: Idea, stocksAPI: StocksAPI = MockStocksAPI()) {
        self.idea = idea
        self.stocksAPI = stocksAPI
    }
    
    func fetchQuote() async {
        phase = .fetching
        
        do {
            let response = try await stocksAPI.fetchQuotes(symbols: idea.symbol)
            if let quote = response.first {
                phase = .success(quote)
            } else {
                phase = .empty
            }
        } catch {
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
    
}
