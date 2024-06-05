//
//  ContentView.swift
//  market
//
//  Created by Nicholas Nelson on 11/23/23.
//

import SwiftUI

class MainViewModel: ObservableObject {
    @Published var selectedNavigationTab: Int = 1
    @Published var selectedWatchlistsTab: Int = 0
    @Published var searchText: String = ""
    @Published var selectedmenuTab: Int = -1
    @Published var selectedProfileTab: Int = 0
    @Published var selectedNotificationsTab: Int = 0
    @Published var selectedFinancesTab: Int = 0
    @Published var selectedNewActionTab: Int = 0
    @Published var selectedPortfolioTab: Int = 0
    @Published var selectedAiTab: Int = 0
    @Published var isSearchBarVisible: Bool = false
    @Published var user: User = User.stub
    @Published var showPopup = false
    
    func toggleSearchBarVisibility() {
        withAnimation {
            isSearchBarVisible.toggle()
        }
    }
    
    func hideSearchBar() {
        withAnimation {
            isSearchBarVisible = false
        }
    }
    
    
    func handleTabSelection(_ tab: Int) {
        if tab >= 1 && tab <= 16 {
            selectedNavigationTab = tab
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel = MainViewModel()
    @State private var selectedToolbarItem: Int? = nil
    @State private var isShowingNewActionView: Bool = false
    @State private var previousSelectedTab: Int = 1
    @State private var isOpened = false
    @State private var isShowingAiSideMenu = false
    @State private var isScrolled: Bool = false
    @State private var xOffset: CGFloat = 0
    @State private var currentXOffset: CGFloat = 0
    @Environment(\.colorScheme) var scheme
    @State private var isShowingSideMenu = false
    @State private var user: User = User.stub
    @State private var showActionBar = false

    
    var body: some View {
        AnimatedSideBar(
            rotatesWhenExpands: true,
            disablesInteraction: true,
            sideMenuWidth: 250, // Customize as needed
            cornerRadius: 20, // Customize as needed
            showMenu: $isShowingSideMenu
        ) { _ in
            ZStack {
                NavigationView {
                    VStack {
                        switch viewModel.selectedNavigationTab {
                        case 0:
                            NewProfileView(user: User.stub)
                        case 1:
//                            NewWatchlistsView(showActionBar: $showActionBar)
                            WatchlistsView(
                                selectedWatchlistsTab: $viewModel.selectedWatchlistsTab )
                            .environmentObject(AppViewModel())
                            
                        case 2:
//                            ExploreView(isOpened: $isOpened)
//                                .environmentObject(viewModel)
                            CategoriesView()
                        case 3:
                            FinancesView(selectedFinancesTab: $viewModel.selectedFinancesTab, selectedPortfolioTab: $viewModel.selectedPortfolioTab, isOpened: $isOpened)
                        case 4:
                            aiView(isOpened: $isOpened, isShowingAiSideMenu: $isShowingAiSideMenu, mainViewModel: viewModel)
                        case 5:
                            ConferencesView(isOpened: $isOpened)
                        case 6:
                            NotificationsView(selectedNotificationsTab: $viewModel.selectedNotificationsTab, isOpened: $isOpened)
                        case 7:
                            InstructionsView()
                        case 8:
                            LeaderboardView()
                        case 9:
                            MainCalendarView(text: MainCalendarView.$searchText, onSearchChanged: { _ in })
                        case 10:
                            MapView()
                        default:
                            Text("Default View")
                        }
                        CustomTabBar(selectedNavigationTab: Binding(
                            get: { self.viewModel.selectedNavigationTab },
                            set: { newValue in
                                self.viewModel.selectedNavigationTab = newValue
                                self.selectedToolbarItem = nil // Reset toolbar item whenever tab changes
                            }
                        ))
                        
                    }
                }
                
                
                if isShowingAiSideMenu {
                                    aiSideMenuView(isShowingAiSideMenu: $isShowingAiSideMenu, selectedAiTab: $viewModel.selectedAiTab)
                                }

                                VStack {
                                    Spacer()
                                    HStack {
                                        Spacer()
                                        if viewModel.selectedNavigationTab != 4 {
                                            FloatingActionButton(viewModel: viewModel, isShowingNewActionView: $isShowingNewActionView, previousSelectedTab: $previousSelectedTab)
                                                .padding(.bottom, 95) // Adjust padding as needed
                                                .padding(.trailing) // Adjust padding as needed
                                        }
                                    }
                                }

                                // Use slideInTransition directly
//                                if isExpandedBinaryViewPresented, let binary = selectedBinary {
//                                    ExpandedBinaryView(binary: binary)
//                                        .background(Color.white.edgesIgnoringSafeArea(.all))
//                                        .onTapGesture {
//                                            withAnimation {
//                                                isExpandedBinaryViewPresented = false
//                                            }
//                                        }
//                                        .slideInTransition(isPresented: $isExpandedBinaryViewPresented)
//                                }
                if showActionBar {
                                    HStack {
                                        Text("Action performed!")
                                            .padding()
                                            .background(Color.gray.opacity(0.9))
                                            .cornerRadius(8)
                                        Spacer()
                                    }
                                    .padding()
                                    .transition(.move(edge: .bottom).combined(with: .opacity))
                                }
                            }
                            .onChange(of: isShowingNewActionView) { showing in
                                if !showing {
                                    viewModel.selectedNavigationTab = previousSelectedTab
                                }
                            }
                            .fullScreenCover(isPresented: $isShowingNewActionView) {
                                NewActionView(selectedNewActionTab: $viewModel.selectedNewActionTab)
                            }
                        } menuView: { _ in
                            // Side menu content
                            MainSideMenu(viewModel: viewModel, isShowingSideMenu: $isShowingSideMenu, user: user)
                        } background: {
                            // Background view
                            Color.primary.opacity(0.5)
                        }
                    }
                }




struct FloatingActionButton: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var isShowingNewActionView: Bool
    @Binding var previousSelectedTab: Int
    
    var body: some View {
        Button(action: {
            previousSelectedTab = viewModel.selectedNavigationTab
            isShowingNewActionView = true
        }) {
            Image(systemName: "laser.burst")
                .font(.title2)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MainViewModel())
    }
}
