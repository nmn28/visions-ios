//
//  MainSideMenu.swift
//  market
//
//  Created by Nicholas Nelson on 3/30/24.
//

import SwiftUI

enum Tab: String, CaseIterable {
    case watchlists = "eye", explore = "safari", finances = "briefcase", ai = "wand.and.stars", categories = "flowchart", notifications = "bell"
    case instructions = "scroll", membership = "star.circle", leaderboard = "person.bust", calendar = "calendar", map = "map"
    case advertise = "signpost.right", settings = "gear", logout = "arrow.right.square"

    var index: Int {
        switch self {
        case .watchlists: return 1
        case .explore: return 2
        case .finances: return 3
        case .ai: return 4
        case .categories: return 5
        case .notifications: return 6
        case .instructions: return 7
        case .membership: return 8
        case .leaderboard: return 9
        case .calendar: return 10
        case .map: return 11
        
        // Add other cases as necessary
        default: return 0 // Default to the first tab or a safe fallback
        }
    }

    var title: String {
        switch self {
        case .watchlists: return "Watchlists"
        case .explore: return "Explore"
        case .finances: return "Finances"
        case .ai: return "AI"
        case .categories: return "Categories"
        case .notifications: return "Notifications"
        case .instructions: return "Instructions"
        case .membership: return "Membership"
        // Continue for other cases...
        case .leaderboard: return "Leaderboard"
        case .calendar: return "Calendar"
        case .map: return "Map"
        case .advertise: return "Advertise"
        case .settings: return "Settings"
        case .logout: return "Logout"
        }
    }


    
    var iconName: String {
        self.rawValue
    }
    
    
}

struct MainSideMenu: View {
    @ObservedObject var viewModel: MainViewModel
    @Binding var isShowingSideMenu: Bool
    var user: User
    @State private var mainTabsExpanded: Bool = false
    @State private var featuresExpanded: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 12) {
                headerView
                profileButton
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 12) {
//                        mainTabsButton
//                        if mainTabsExpanded {
//                            ForEach(Tab.allCases.prefix(6), id: \.self) { tab in
//                                SideBarButton(tab: tab, isSelected: viewModel.selectedNavigationTab == tab.index) {
//                                    viewModel.handleTabSelection(tab.index)
//                                    self.isShowingSideMenu = false
//                                }
//                            }
//                        }
//                        
//                        Divider()
                        
                        featuresButton
                        if featuresExpanded {
                            ForEach(Tab.allCases.dropFirst(6), id: \.self) { tab in
                                SideBarButton(tab: tab, isSelected: viewModel.selectedNavigationTab == tab.index) {
                                    viewModel.handleTabSelection(tab.index)
                                    self.isShowingSideMenu = false
                                }
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding([.horizontal, .vertical], 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .background(Color(.systemBackground).edgesIgnoringSafeArea(.all))
        }
    }
    
    
    var headerView: some View {
        HStack {
            
            Image(systemName: "laser.burst")
                .font(.title2)
                .padding(.bottom, 10)
            
            Text("Visions")
                .font(.title2)
                .padding(.bottom, 10)
        }
    }
    
    var profileButton: some View {
        Button(action: {
            // Update the selected navigation tab to the index corresponding to the Profile View
            viewModel.selectedNavigationTab = 0
            self.isShowingSideMenu = false // Close the side menu
        }) {
            HStack {
                UserImage(imageName: user.imageName, isOnline: user.isOnline, size: 50)
                VStack(alignment: .leading) {
                    Text(user.name)
                        .font(.headline)
                    Text(user.username)
                        .font(.subheadline)
                }
            }
            .padding(.vertical, 10)
        }
        .contentShape(Rectangle())
        .foregroundStyle(Color.primary)
    }
    
    var mainTabsButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                mainTabsExpanded.toggle()
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: "menubar.dock.rectangle")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 45, alignment: .center)  // Ensures consistent icon size
                
                Text("Main Tab Bar")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)  // Text alignment and spacing
                
                
                Image(systemName: mainTabsExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 10)
        }
    }
    
    var featuresButton: some View {
        Button(action: {
            withAnimation(.easeInOut) {
                featuresExpanded.toggle()
            }
        }) {
            HStack(spacing: 12) {
                Image(systemName: "list.star")
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 45, alignment: .center)  // Ensures consistent icon size
                
                Text("Features")
                    .foregroundColor(.primary)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)  // Text alignment and spacing
                
                
                Image(systemName: featuresExpanded ? "chevron.up" : "chevron.down")
                    .foregroundColor(.primary)
            }
            .padding(.vertical, 10)
        }
    }
    
    func performActionForTab(_ tab: Tab) {
        print("Selected \(tab.title)")
        self.isShowingSideMenu = false
    }
    
    @ViewBuilder
    func SideBarButton(tab: Tab, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 12) {
                Image(systemName: tab.iconName)
                    .font(.title2)
                    .foregroundColor(isSelected ? .accentColor : .primary)  // Change color based on selection
                    .frame(width: 45, alignment: .center)
                
                Text(tab.title)
                    .foregroundColor(isSelected ? .accentColor : .primary)  // Change color based on selection
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()  // Ensures that the text and icon are left-aligned
            }
            .padding(.vertical, 10)
            .padding(.leading, isSelected ? 20 : 0)
            .padding(.leading, 20)
        }
    }
}


struct MainSideMenu_Previews: PreviewProvider {
    static var previews: some View {
        MainSideMenu(
            viewModel: MainViewModel(), // Create an instance of MainViewModel
            isShowingSideMenu: .constant(true),
            user: User.stub // Make sure User.stub provides a valid User instance
        )
    }
}

//    @ViewBuilder
//    func SideBarMenuView() -> some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Spacer()
//            HStack {
//                Text("Forecast.ai")
//                    .font(.title.bold())
//                    .padding(.bottom, 10)
//                
//                Image(systemName: "rays")
//                    .font(.title.bold())
//                    .padding(.bottom, 10)
//            }
//            
//            Button(action: {
//                        ProfileView()
//                        self.isShowingSideMenu = false
//                    }) {
//                        HStack {
//                            UserImage(imageName: user.imageName, isOnline: user.isOnline, size: 50)
//                            VStack(alignment: .leading) {
//                                Text(user.name)
//                                    .font(.headline)
//                                Text(user.username)
//                                    .font(.subheadline)
//                            }
//                        }
//                        .padding(.vertical, 10)
//                    }
//                    .contentShape(Rectangle())
//                    .foregroundStyle(Color.primary)
//            
//            ForEach(Tab.allCases, id: \.self) { tab in
//                SideBarButton(tab: tab) {
//                    self.selectedNavigationTab = tab.rawValue
//                    self.isShowingSideMenu = false
//                }
//            }
//            
//            Spacer()
//        }
//        .padding([.horizontal, .vertical], 30)
//        
//        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .environment(\.colorScheme, .dark)
////        .edgesIgnoringSafeArea(.all)
//    }
//
//    @ViewBuilder
//    func SideBarButton(tab: Tab, onTap: @escaping () -> Void) -> some View {
//        Button(action: onTap) {
//            HStack(spacing: 15) { // Adjust spacing as needed
//                Image(systemName: tab.iconName) // Icon
//                    .font(.title3)
//                    .frame(width: 24, alignment: .center) // Ensure icons are centered and have a fixed width for alignment
//
//                Text(tab.title) // Title
//                    .font(.callout)
//                    .frame(alignment: .leading) // Ensure text is aligned to the leading edge
//                
//                Spacer() // Pushes content to the left
//            }
//            .padding(.vertical, 10)
//            .contentShape(Rectangle())
//            .foregroundStyle(Color.primary)
//        }
//    }
//}

