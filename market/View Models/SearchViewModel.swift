//
//  SearchViewModel.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Combine
import Foundation
import SwiftUI

@MainActor
class SearchViewModel: ObservableObject {

    @Published var query: String = ""
    @Published var phase: FetchPhase<[Idea]> = .initial
    
    private var trimmedQuery: String {
        query.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var ideas: [Idea] { phase.value ?? [] }
    var error: Error? { phase.error }
    var isSearching: Bool { !trimmedQuery.isEmpty }
    
    var emptyListText: String {
        "Symbols not found for\n\"\(query)\""
    }
    
    private var cancellables = Set<AnyCancellable>()
    private let stocksAPI: StocksAPI
    
    init(query: String = "", stocksAPI: StocksAPI = MockStocksAPI()) {
        self.query = query
        self.stocksAPI = stocksAPI
        
        startObserving()
    }
    
    private func startObserving() {
        $query
            .debounce(for: 0.25, scheduler: DispatchQueue.main)
            .sink { _ in
                Task { [weak self] in await self?.searchIdeas() }
            }
            .store(in: &cancellables)
        
        $query
            .filter { $0.isEmpty }
            .sink { [weak self] _ in self?.phase = .initial }
            .store(in: &cancellables)
    }
    
    func searchIdeas() async {
        let searchQuery = trimmedQuery
        guard !searchQuery.isEmpty else { return }
        phase = .fetching
        
        do {
            let ideas = try await stocksAPI.searchIdeas(query: searchQuery, isEquityTypeOnly: true)
            if searchQuery != trimmedQuery { return }
            if ideas.isEmpty {
                phase = .empty
            } else {
                phase = .success(ideas)
            }
        } catch {
            if searchQuery != trimmedQuery { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    }
    
}

