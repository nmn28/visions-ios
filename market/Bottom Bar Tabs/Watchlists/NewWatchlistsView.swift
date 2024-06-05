//
//  NewWatchlistsView.swift
//  market
//
//  Created by Nicholas Nelson on 5/7/24.
//

import SwiftUI

struct NewWatchlistsView: View {
    @ObservedObject private var navBarInfo = NavBarInfo.shared

    /// View Properties
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.research),
        .init(id: TabModel.Tab.deployment),
        .init(id: TabModel.Tab.analytics),
        .init(id: TabModel.Tab.audience),
        .init(id: TabModel.Tab.privacy)
    ]
    @Binding var showActionBar: Bool
    @State private var activeTab: TabModel.Tab = .research
    @State private var tabBarScrollState: TabModel.Tab?
    @State private var mainViewScrollState: TabModel.Tab?
    @State private var progress: CGFloat = .zero
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedBinary: Binary?
//    @Binding var isExpandedBinaryViewPresented: Bool
    
//    init(isExpandedBinaryViewPresented: Binding<Bool>, selectedBinary: Binding<Binary?>) {
//        _isExpandedBinaryViewPresented = isExpandedBinaryViewPresented
//        _selectedBinary = selectedBinary
//    }
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HeaderView()
                CustomTabBar()
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .offset(y: navBarInfo.offset)
            .zIndex(1)
            
            GeometryReader { proxy in
                let size = proxy.size
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 0) {
                        ForEach(tabs) { tab in
                            switch tab.id {
                            case .research:
                                ListedBinaryView(
                                    binary: Binary(
                                        name: "Jane Doe",
                                        username: "@jane",
                                        title: "AI Will Be President",
                                        body: "We are approaching GPT 5, and it is supposed to be exponentially better than the last model.",
                                        media: .photo(Image("placeholderImage")),  // Assuming you have a placeholder image in your assets
                                        priceChange: "+$2.00",
                                        priceChangePercentage: "+1.25%"
                                    ),
                                    selectedBinary: .constant(nil), showActionBar: .constant(false)
                                )
                            case .deployment:
                                ListedBinaryView(
                                    binary: Binary(
                                        name: "Jane Doe",
                                        username: "@jane",
                                        title: "AI Will Be President",
                                        body: "We are approaching GPT 5, and it is supposed to be exponentially better than the last model.",
                                        media: .photo(Image("placeholderImage")),  // Assuming you have a placeholder image in your assets
                                        priceChange: "+$2.00",
                                        priceChangePercentage: "+1.25%"
                                    ),
                                    selectedBinary: .constant(nil), showActionBar: .constant(false)
                                )
                            case .analytics:
                                ListedStockView(
                                    stock: Stock(
                                        name: "Jane Doe",
                                        username: "@jane",
                                        title: "AI Will Be President",
                                        body: "We are approaching GPT 5, and it is supposed to be exponentially better than the last model.",
                                        stockMedia: .photo(Image("placeholderImage")),  // Assuming you have a placeholder image in your assets
                                        priceChange: "+$2.00",
                                        priceChangePercentage: "+1.25%"
                                    )
                                )
                            case .audience:
                                DevelopmentView()
                            case .privacy:
                                DevelopmentView()
                            }
                        }
                    }
                    .scrollTargetLayout()
                    .rect { rect in
                        progress = -rect.minX / size.width
                    }
                }
                .scrollPosition(id: $mainViewScrollState)
                .scrollIndicators(.hidden)
                .scrollTargetBehavior(.paging)
                .onChange(of: mainViewScrollState) { oldValue, newValue in
                    if let newValue = newValue {
                        withAnimation(.snappy) {
                            tabBarScrollState = newValue
                            activeTab = newValue
                        }
                    }
                }
            }
            .ignoresSafeArea(.all)
            .frame(maxHeight: .infinity)
        }
    }
    
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Image(systemName: "laser.burst")
                .font(.title2)
            Text("Visions")
                .font(.title2)
            
            Spacer(minLength: 0)
            
            Spacer()
            /// Buttons
            Button("", systemImage: "plus.circle") {
                
            }
            .font(.title2)
            .tint(.primary)
            
            Button("", systemImage: "bell") {
                
            }
            .font(.title2)
            .tint(.primary)
            
            /// Profile Button
            Button(action: {}, label: {
                Image(.pic)  // Assuming you have a placeholder image named "pic" in your assets
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(Circle())
            })
        }
        .padding(15)
        /// Divider
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 1)
        }
    }
    
    /// Dynamic Scrollable Tab Bar
    @ViewBuilder
    func CustomTabBar() -> some View {
        ScrollView(.horizontal) {
            HStack(spacing: 20) {
                ForEach($tabs) { $tab in
                    Button(action: {
                        withAnimation(.snappy) {
                            activeTab = tab.id
                            tabBarScrollState = tab.id
                            mainViewScrollState = tab.id
                        }
                    }) {
                        Text(tab.id.rawValue)
                            .fontWeight(.medium)
                            .padding(.vertical, 12)
                            .foregroundStyle(activeTab == tab.id ? Color.primary : .gray)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())
                    .rect { rect in
                        tab.size = rect.size
                        tab.minX = rect.minX
                    }
                }
            }
            .scrollTargetLayout()
        }
        .scrollPosition(id: .init(get: {
            return tabBarScrollState
        }, set: { _ in
            
        }), anchor: .center)
        .overlay(alignment: .bottom) {
            ZStack(alignment: .leading) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, -15)
                
                let inputRange = tabs.indices.map { CGFloat($0) }
                let outputRange = tabs.map { $0.size.width }
                let outputPositionRange = tabs.map { $0.minX }
                let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: outputRange)
                let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: indicatorWidth, height: 1.5)
                    .offset(x: indicatorPosition)
            }
        }
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    NewWatchlistsView(showActionBar: .constant(false))
}
