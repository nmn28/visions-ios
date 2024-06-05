//
//  QuotesViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation
import SwiftUI

@MainActor
class QuotesViewModel: ObservableObject {
    
    @Published var quotesDict: [String: Quote] = [:]
    let stocksAPI: StocksAPI
    
    init(stocksAPI: StocksAPI = MockStocksAPI()) {
        self.stocksAPI = stocksAPI
    }
    
    func fetchQuotes(ideas: [Idea]) async {
        guard !ideas.isEmpty else { return }
        do {
            let symbols = ideas.map { $0.symbol }.joined(separator: ",")
            let quotes = try await stocksAPI.fetchQuotes(symbols: symbols)
            var dict = [String: Quote]()
            quotes.forEach { dict[$0.symbol] = $0 }
            self.quotesDict = dict
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func priceForIdea(_ idea: Idea) -> PriceChange? {
        guard let quote = quotesDict[idea.symbol],
              let price  = quote.regularPriceText,
              let change = quote.regularDiffText
        else { return nil }
        return (price, change)
    }
    
}
