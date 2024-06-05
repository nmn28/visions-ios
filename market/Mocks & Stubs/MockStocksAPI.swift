//
//  MockStocksAPI.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation
//import XCAStocksAPI

#if DEBUG
struct MockStocksAPI: StocksAPI {
    
    var stubbedSearchIdeasCallback: (() async throws -> [Idea])!
    func searchIdeas(query: String, isEquityTypeOnly: Bool) async throws -> [Idea] {
        try await stubbedSearchIdeasCallback()
    }
    
    var stubbedFetchQuotesCallback: (() async throws -> [Quote])!
    func fetchQuotes(symbols: String) async throws -> [Quote] {
        try await stubbedFetchQuotesCallback()
    }
    
    var stubbedFetchChartDataCallback: ((ChartRange) async throws  -> ChartData?)! = { $0.stubs }
    func fetchChartData(ideaSymbol: String, range: ChartRange) async throws -> ChartData? {
        try await stubbedFetchChartDataCallback(range)
    }
    
}
#endif
