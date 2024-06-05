//
//  CategoriesView.swift
//  market
//
//  Created by Nicholas Nelson on 3/11/24.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject private var navBarInfo = NavBarInfo.shared

//    / View Properties
    @State private var tabs: [TabModel] = [
        .init(id: TabModel.Tab.research),
        .init(id: TabModel.Tab.deployment),
        .init(id: TabModel.Tab.analytics),
        .init(id: TabModel.Tab.audience),
        .init(id: TabModel.Tab.privacy)
    ]
    @State private var activeTab: TabModel.Tab = .research
    @State private var tabBarScrollState: TabModel.Tab?
    @State private var mainViewScrollState: TabModel.Tab?
    @State private var progress: CGFloat = .zero
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                HeaderView()
//                CustomTabBar()
            }
            .background(colorScheme == .dark ? Color.black : Color.white)
            .offset(y: navBarInfo.offset)
            .zIndex(1)
            
            GeometryReader {
                let size = $0.size
                
                GeometryReader { geometry in
                    ScrollView(.vertical) { // Assuming you want vertical scrolling for the content
                        CategoriesSuggestions()
                            .frame(width: geometry.size.width)
                            /*.padding(.top, 120)*/ // Adjust top padding based on header height
                    }
                    .ignoresSafeArea(.all)
                }
//                .frame(maxHeight: .infinity)
                .zIndex(0) // Ensuring it's below the header
            }
        }
    }
    @ViewBuilder
    func HeaderView() -> some View {
        HStack {
            Image(systemName: "flowchart")
                .font(.title2)
            Text("Categories")
                .font(.title2)
//            Image(.logo)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
//                .frame(width: 100)
            
            Spacer(minLength: 0)
            
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
                Image(.pic)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 30, height: 30)
                    .clipShape(.circle)
            })
        }
        .padding(15)
        /// Divider
        .overlay(alignment: .bottom) {
            Rectangle()
                .fill(.gray.opacity(0.3))
                .frame(height: 1)
        }
    }
    
//    / Dynamic Scrollable Tab Bar
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
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
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
                    .fill(.gray.opacity(0.3))
                    .frame(height: 1)
                    .padding(.horizontal, -15)
                
                let inputRange = tabs.indices.compactMap { return CGFloat($0) }
                let ouputRange = tabs.compactMap { return $0.size.width }
                let outputPositionRange = tabs.compactMap { return $0.minX }
                let indicatorWidth = progress.interpolate(inputRange: inputRange, outputRange: ouputRange)
                let indicatorPosition = progress.interpolate(inputRange: inputRange, outputRange: outputPositionRange)
                
                Rectangle()
                    .fill(.primary)
                    .frame(width: indicatorWidth, height: 1.5)
                    .offset(x: indicatorPosition)
            }
        }
        .safeAreaPadding(.horizontal, 15)
        .scrollIndicators(.hidden)
    }
}

#Preview {
    CategoriesView()
}
