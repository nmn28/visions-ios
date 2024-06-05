//
//  PortfolioCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 12/28/23.
//

import SwiftUI

enum portfolioTabContent {
    case symbol(String)
    case text(String)
    case both(symbol: String, text: String)

    var symbolName: String? {
        switch self {
            case .symbol(let symbol), .both(symbol: let symbol, text: _):
                return symbol
            case .text:
                return nil
        }
    }

    var text: String? {
        switch self {
            case .text(let text), .both(symbol: _, text: let text):
                return text
            case .symbol:
                return nil
        }
    }
}

struct PortfolioCustomPicker: View {
    @Binding var selectedPortfolioTab: Int
    var tabs: [portfolioTabContent]
    let contentBuilders: [(Int) -> AnyView]

    var body: some View {
        VStack(spacing: 0) {
            GeometryReader { geometry in
                VStack(spacing: 0) {
                    ZStack(alignment: .bottomLeading) {
                        // Horizontal ScrollView for the buttons
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 0) {
                                ForEach(tabs.indices, id: \.self) { index in
                                    Button(action: {
                                        withAnimation {
                                            selectedPortfolioTab = index
                                        }
                                    }) {
                                        tabButtonContent(for: index)
                                            .frame(width: geometry.size.width / CGFloat(tabs.count))
                                    }
                                }
                            }
                        }

                        // Sliding Rectangle
                        Rectangle()
                            .frame(width: geometry.size.width / CGFloat(tabs.count), height: 2)
                            .offset(x: CGFloat(selectedPortfolioTab) * (geometry.size.width / CGFloat(tabs.count)), y: 8)
                            .foregroundColor(Color.accentColor)
                    }

                    // Divider
                    Divider().background(Color.gray).padding(.top, 8)
                }
            }
            .frame(height: 40)

            // Tab Content
            TabView(selection: $selectedPortfolioTab) {
                ForEach(tabs.indices, id: \.self) { index in
                    contentBuilders[index](index)
                        .tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        }
        .padding(.vertical, 5)
    }

    private func tabButtonContent(for index: Int) -> some View {
        let content = tabs[index]
        let isActive = selectedPortfolioTab == index

        return HStack {
            if let symbolName = content.symbolName {
                Image(systemName: symbolName)
                    .imageScale(.medium) // Adjust the scale here
//                    .font(.system(size: 16))
                    .foregroundColor(isActive ? Color.accentColor : Color.gray)
            }
            if let text = content.text {
                Text(text)
                    .font(.system(size: isActive ? 18 : 16))
                    .foregroundColor(isActive ? Color.accentColor : Color.gray)
            }
        }
    }
}

struct PortfolioCustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        // Define the tabs
        let tabs: [portfolioTabContent] = [
                   .symbol("bird"),
                   .symbol("arrowshape.turn.up.backward"),
                   .symbol("storefront"),
                   .symbol("calendar"),
                   .symbol("dollarsign.arrow.circlepath"),
                   .symbol("photo.stack"),
                   .symbol("flame")
               ]

        let contentBuilders: [(Int) -> AnyView] = [
            { _ in AnyView(Text("Heart Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Star Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) },
            { _ in AnyView(Text("Bell Content").frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top).padding(.top, 5)) }
            // Add more content views for each tab as needed
        ]
        
        // Define a state for the selected tab to be used in the preview
        PortfolioStatefulPreviewWrapper(0) { selectedTab in
            PortfolioCustomPicker(selectedPortfolioTab: selectedTab, tabs: tabs, contentBuilders: contentBuilders)
        }
    }
}

// Helper struct to provide a mutable state for previews
struct PortfolioStatefulPreviewWrapper<Value, Content: View>: View {
    @State private var value: Value
    let content: (Binding<Value>) -> Content

    init(_ initialValue: Value, @ViewBuilder content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: initialValue)
        self.content = content
    }

    var body: some View {
        content($value)
    }
}
