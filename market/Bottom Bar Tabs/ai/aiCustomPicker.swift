//
//  aiCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 1/23/24.
//

import SwiftUI

import SwiftUI

enum aiTabContent {
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

enum aiCategory: String, CaseIterable {
    case foryou = "For You"
    case following = "Following"
    case recent = "Most Recent"
    case posted = "Posted by Me"
    case invested = "Invested in"
    case saved = "Saved by Me"
    

    var systemImageName: String {
        switch self {
        case .foryou: return "heart.text.square"
        case .following: return "binoculars"
        case .recent: return "arrow.circlepath"
        case .posted: return "paperplane"
        case .invested: return "banknote"
        case .saved: return "eye"
        }
    }
}

struct aiCustomPicker: View {
    @Binding var selectedAiTab: Int
    var tabs: [aiTabContent]
    let contentBuilders: [(Int) -> AnyView]

    var aiTabContentName: String {
            switch selectedAiTab {
            case 0: return "All"
            case 1: return "Predictions"
            case 2: return "Events"
            case 3: return "Markets"
            case 4: return "Disputes"
            case 5: return "Transactions"
            case 6: return "My Investments"
            case 7: return "Personal"
            
            default: return "Unknown"
            }
        }
    
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
                                            selectedAiTab = index
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
                            .offset(x: CGFloat(selectedAiTab) * (geometry.size.width / CGFloat(tabs.count)), y: 8)
                            .foregroundColor(Color.accentColor)
                    }

                    // Divider
                    Divider().background(Color.gray).padding(.top, 8)
                }
            }
            .frame(height: 40)

            Menu {
                // The list of options
                ForEach(aiCategory.allCases, id: \.self) { category in
                    Button(category.rawValue, action: {
                        // Perform actions when a category is selected
                    })
                }
            } label: {
                // The button label showing the current selection and chevron
                HStack {
                    Text(aiTabContentName)
                    Image(systemName: "chevron.up.chevron.down")
                }
                .foregroundColor(.primary)
            }
            .padding(.bottom, 5)
            
            // Tab Content
            TabView(selection: $selectedAiTab) {
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
        let isActive = selectedAiTab == index

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

struct aiCustomPicker_Previews: PreviewProvider {
    static var previews: some View {
        // Define the tabs
        let tabs: [aiTabContent] = [
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
        aiStatefulPreviewWrapper(0) { selectedTab in
           aiCustomPicker(selectedAiTab: selectedTab, tabs: tabs, contentBuilders: contentBuilders)
        }
    }
}

// Helper struct to provide a mutable state for previews
struct aiStatefulPreviewWrapper<Value, Content: View>: View {
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

