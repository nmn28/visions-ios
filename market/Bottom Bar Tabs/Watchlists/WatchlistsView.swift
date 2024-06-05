//
//  WatchlistsView.swift
//  market
//
//  Created by Nicholas Nelson on 11/23/23.
//

import SwiftUI

struct WatchlistsView: View {
    @State var headerHeight: CGFloat = 0
    @State var headerOffset: CGFloat = 0
    @EnvironmentObject var appVM: AppViewModel
    @StateObject var quotesVM = QuotesViewModel()
    @StateObject var searchVM = SearchViewModel()
    @Binding var selectedWatchlistsTab: Int
    @State private var showingOptions = false
    @State private var isPickerSticky = false
    @State private var scrollOffset: CGFloat = 0
    @State private var isNavigationBarVisible: Bool = true
    @State private var collapseProgress: CGFloat = 0
    //    @State private var isSideMenuOpen: Bool = false
    
//    @Binding var isOpened: Bool
    
    @Environment(\.colorScheme) private var colorScheme
    
//    @State private var selection: MenuItem? = .Messages
//    @State var appearance: MenuAppearance = .default
    @State private var isScrolled: Bool = false
    @State private var showCalendar: Bool = false
    
    
    var body: some View {

        VStack {

            WatchlistsCustomPicker()

        }
        .navigationTitle("")
//        .toolbar {
//            titleToolbar
//        }
//        .navigationTitle("Watchlists")
//        .navigationBarTitleDisplayMode(.inline)
//        .toolbar {
//                            ToolbarItemGroup(placement: .navigationBarTrailing) {
//                                Button(action: {
//                                    // Add action for magnifying glass
//                                }) {
//                                    Image(systemName: "magnifyingglass")
//                                }
//
//                                Button(action: {
//                                    // Add action for menu card
//                                }) {
//                                    Image(systemName: "line.horizontal.3")
//                                }
//                            }
//                        }
//                    
//        .searchable(text: $searchVM.query)
    }
//}

    struct ViewOffsetKey: PreferenceKey {
        static var defaultValue: CGFloat = 0
        static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
            value = nextValue()
        }
    }
    
    struct WatchlistsCustomToolbar: View {
        @Binding var isOpened: Bool
        @Binding var showCalendar: Bool
        
        var body: some View {
            CustomToolbar(
                leftContent: {
                    AnyView(VStack(alignment: .leading, spacing: -4) {
                        Text("Forecast.ai")
                            .font(.title3).fontWeight(.heavy)
                            .bold()
                        Text("date")
                            .font(.title3).fontWeight(.heavy)
                            .bold()
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    })
                },
                centerContent: {
                    AnyView(Text("Watchlists").font(.headline))
                },
                rightContent: {
                    AnyView(HStack(spacing: 20) {
                        Button(action: {
                            showCalendar.toggle()
                        }) {
                            Image(systemName: "calendar")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                            
                        }
                        Button(action: {
                            
                        }) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {
                            isOpened.toggle()
                        }) {
                            Image(systemName: "menucard")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    })
                }
            )
        }
    }

    private var ideaListView: some View {
            List {
                ForEach(appVM.ideas) { idea in
                    let graphData = [100.0, 105.0, 103.0, 110.0]
                    
                    IdeaListRowView(
                        graphData: graphData,
                        data: .init(
                            symbol: idea.symbol,
                            name: idea.shortname,
                            price: quotesVM.priceForIdea(idea),
                            type: .main))
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appVM.selectedIdea = idea
                    }
                }
                .onDelete { appVM.removeIdeas(atOffsets: $0) }
                
            }
            .opacity(searchVM.isSearching ? 0 : 1)
            .listStyle(.plain)
            //        .overlay { overlayView }
            
            .refreshable { await quotesVM.fetchQuotes(ideas: appVM.ideas) }
            .sheet(item: $appVM.selectedIdea) {
                StockChartView(chartVM: ChartViewModel(idea: $0, apiService: quotesVM.stocksAPI), quoteVM: .init(idea: $0, stocksAPI: quotesVM.stocksAPI))
                    .presentationDetents([.height(560)])
            }
            .task(id: appVM.ideas) { await quotesVM.fetchQuotes(ideas: appVM.ideas) }
        }

    
    @ViewBuilder
    private var overlayView: some View {
        if appVM.ideas.isEmpty {
            EmptyStateView(text: appVM.emptyIdeasText)
        }
        
        if searchVM.isSearching {
            SearchView(searchVM: searchVM)
        }
    }
    
    private var titleToolbar: some ToolbarContent {
        ToolbarItem(placement: .navigationBarLeading) {
            VStack(alignment: .leading, spacing: -4) {
                Text(appVM.titleText)
                Text(appVM.subtitleText).foregroundColor(Color(uiColor: .secondaryLabel))
            }.font(.title3.weight(.heavy))
                .padding(.bottom)
        }
    }
}

struct WatchlistsView_Previews: PreviewProvider {
    @State static var isOpened = false
    static var appVM: AppViewModel = {
        var mock = MockIdeaListRepository()
        mock.stubbedLoad = { Idea.stubs }
        return AppViewModel(repository: mock)
    }()
    
    static var emptyAppVM: AppViewModel = {
        var mock = MockIdeaListRepository()
        mock.stubbedLoad = { [] }
        return AppViewModel(repository: mock)
    }()
    
    static var quotesVM: QuotesViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedFetchQuotesCallback = { Quote.stubs }
        return QuotesViewModel(stocksAPI: mock)
    }()
    
    static var searchVM: SearchViewModel = {
        var mock = MockStocksAPI()
        mock.stubbedSearchIdeasCallback = { Idea.stubs }
        return SearchViewModel(stocksAPI: mock)
    }()
    
    static var previews: some View {
        Group {
            NavigationStack {
               WatchlistsView(quotesVM: quotesVM, searchVM: searchVM, selectedWatchlistsTab: .constant(0))
                    .environmentObject(appVM)
                    .previewDisplayName("With Idea")
            }

            NavigationStack {
                WatchlistsView(quotesVM: quotesVM, searchVM: searchVM, selectedWatchlistsTab: .constant(0))
                    .environmentObject(emptyAppVM)
                    .previewDisplayName("With Empty Ideas")
            }
        }
    }
}
