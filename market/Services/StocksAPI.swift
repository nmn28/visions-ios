//
//  StocksAPI.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation

protocol StocksAPI {
    func searchIdeas(query: String, isEquityTypeOnly: Bool) async throws -> [Idea]
    func fetchQuotes(symbols: String) async throws -> [Quote]
    func fetchChartData(ideaSymbol: String, range: ChartRange) async throws -> ChartData?
}

//extension XCAStocksAPI: StocksAPI {}
