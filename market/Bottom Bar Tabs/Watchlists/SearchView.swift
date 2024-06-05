//
//  SearchView.swift
//  market
//
//  Created by Nicholas Nelson on 11/25/23.
//

import SwiftUI

struct SearchView: View {
    
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @ObservedObject var searchVM: SearchViewModel
    
    var body: some View {
        List(searchVM.ideas) { idea in
            // Placeholder data for the mini-graph
            let graphData = [100.0, 105.0, 103.0, 110.0] // Replace this with real data for each ticker
            
            IdeaListRowView(
                graphData: graphData, // Provide the graph data here
                data: .init(
                    symbol: idea.symbol,
                    name: idea.shortname,
                    price: quotesVM.priceForIdea(idea),
                    type: .search(
                        isSaved: appVM.isAddedToMyIdeas(idea: idea),
                        onButtonTapped: {
                            Task { @MainActor in
                                appVM.toggleIdea(idea)
                            }
                        }
                    )
                )
            )
            .contentShape(Rectangle())
            .onTapGesture {
                Task { @MainActor in
                    appVM.selectedIdea = idea
                }
            }
        }
        .listStyle(.plain)
        .refreshable { await quotesVM.fetchQuotes(ideas: searchVM.ideas) }
        .task(id: searchVM.ideas) { await quotesVM.fetchQuotes(ideas: searchVM.ideas) }
        .overlay { listSearchOverlay }
    }
    
    @ViewBuilder
    private var listSearchOverlay: some View {
        switch searchVM.phase {
        case .failure(let error):
            ErrorStateView(error: error.localizedDescription) {
                Task { await searchVM.searchIdeas() }
            }
        case .empty:
            EmptyStateView(text: searchVM.emptyListText)
        case .fetching:
            LoadingStateView()
        default: EmptyView()
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    
    @StateObject static var stubbedSearchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchIdeasCallback = { Idea.stubs }
        return SearchViewModel(query: "Apple", stocksAPI: mock)
    }()
    
    @StateObject static var emptySearchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchIdeasCallback = { [] }
        return SearchViewModel(query: "Theranos", stocksAPI: mock)
    }()
    
    @StateObject static var loadingSearchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchIdeasCallback = {
            await withCheckedContinuation { _ in }
        }
        return SearchViewModel(query: "Apple", stocksAPI: mock)
    }()
    
    @StateObject static var errorSearchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchIdeasCallback = { throw NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "An Error has been occured"]) }
        return SearchViewModel(query: "Apple", stocksAPI: mock)
    }()
    
    @StateObject static var appVM: AppViewModel = {
        var mock = MockIdeaListRepository()
        mock.stubbedLoad = { Array(Idea.stubs.prefix(upTo: 2)) }
        return AppViewModel(repository: mock)
    }()
        
    static var quotesVM: QuotesViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedFetchQuotesCallback = { Quote.stubs }
        return QuotesViewModel(stocksAPI: mock)
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: stubbedSearchVM)
            }
            .searchable(text: $stubbedSearchVM.query)
            .previewDisplayName("Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: emptySearchVM)
            }
            .searchable(text: $emptySearchVM.query)
            .previewDisplayName("Empty Results")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: loadingSearchVM)
            }
            .searchable(text: $loadingSearchVM.query)
            .previewDisplayName("Loading State")
            
            NavigationStack {
                SearchView(quotesVM: quotesVM, searchVM: errorSearchVM)
            }
            .searchable(text: $errorSearchVM.query)
            .previewDisplayName("Error State")
            
            
        }.environmentObject(appVM)
    }
}
