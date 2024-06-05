//
//  FinancesCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 12/27/23.
//

import SwiftUI

 struct FinancesTab: Identifiable, Hashable {
     var id: UUID = UUID()
     var title: String?
     var imageName: String?
     var iconName: String?
     var width: CGFloat = 0
     var minX: CGFloat = 0
     
     // Title is same as the Asset Image Name
     static var sampleTabs: [FinancesTab] = [
         .init(iconName: "banknote"),
         .init(iconName: "creditcard"),
         .init(iconName: "chart.bar.xaxis")
         
     ]
 }
 
//struct ComplexView: View {
//    var onSwipeUp: (() -> Void)?
//    var body: some View {
//        VStack {
//            Text("Complex View")
//                .font(.title)
//            Image(systemName: "star.fill")
//                .resizable()
//                .frame(width: 100, height: 100)
//                .foregroundColor(.yellow)
//            Button("Click Me") {
//                print("Button clicked")
//            }
//            .padding()
//            .background(Color.blue)
//            .foregroundColor(.white)
//            .cornerRadius(8)
//        }
//    }
//}

//struct FinancesCustomToolbar: View {
//    
//    @Binding var showCalendar: Bool
//    
//    var body: some View {
//        CustomToolbar(
//            leftContent: {
//                AnyView(VStack(alignment: .leading, spacing: -4) {
//                    Text("Forecast.ai")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                    Text("date")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                        .foregroundColor(Color(uiColor: .secondaryLabel))
//                })
//            },
//            centerContent: {
//                AnyView(Text("Watchlists").font(.headline))
//            },
//            rightContent: {
//                AnyView(HStack(spacing: 20) {
//                    Button(action: {
//                        showCalendar.toggle()
//                    }) {
//                        Image(systemName: "calendar")
//                            .imageScale(.large)
//                            .foregroundColor(.blue)
//                    }
//                    Button(action: {
//                        
//                    }) {
//                        Image(systemName: "magnifyingglass")
//                            .imageScale(.large)
//                            .foregroundColor(.blue)
//                    }
//                    Button(action: {
//                       
//                    }) {
//                        Image(systemName: "menucard")
//                            .imageScale(.large)
//                            .foregroundColor(.blue)
//                    }
//                })
//            }
//        )
//    }
//}

struct FinancesTabView: View {
    @Binding var tabs: [FinancesTab]
    @Binding var currentTab: FinancesTab
    @Binding var indicatorWidth: CGFloat
    @Binding var indicatorPosition: CGFloat
    let onSwipe: (FinancesSwipeDirection) -> Void
    let totalBalance = 17000.0
    @State private var contentOffset: CGFloat = 0
    @State private var reloadToggle = false
    
    /// Calculating Tab Width & Position
    func updateTabFrame(_ tabViewWidth: CGFloat) {
        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
            return CGFloat(index) * tabViewWidth
        }
        
        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
            return tab.width
        }
        
        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
            return tab.minX
        }
        
        let widthInterpolation = FinancesLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        let positionInterpolation = FinancesLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
        
        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
    }
    
    func index(of tab: FinancesTab) -> Int {
        return tabs.firstIndex(of: tab) ?? 0
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
                // Use a GeometryReader to adjust the view based on the tab index
                GeometryReader { geometry in
                    // Determine the view to display based on the index
                    switch index {
                    case 0:
                        PortfolioView(investments: Investment.sampleInvestments, balance: totalBalance)
//                        PortfolioView()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
                    case 1:
                        WalletView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                    case 2:
                        AnalyticsView()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        // Add more cases as needed for additional tabs
                    default:
                        Text("Tab \(index + 1)")
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .clipped()
                .ignoresSafeArea()
                .FinancesoffsetX { rect in
                    if currentTab.id == tab.id {
                        contentOffset = rect.minX - (rect.width * CGFloat(self.index(of: tab)))
                    }
                    updateTabFrame(rect.width)
                }
                .tag(tab)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .animation(.easeInOut, value: currentTab)
        .ignoresSafeArea(edges: .bottom)
        .FinancesdetectSwipe(
            onSwipe: { direction in
                onSwipe(direction)
            }
        )
    }
}

enum FinancesSwipeDirection {
    case up, down, left, right, none
}

struct FinancesListView: View {
    let onSwipe: (FinancesSwipeDirection) -> Void
    @State private var previousOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = 0
    @State private var swipeDirection: FinancesSwipeDirection = .none
    @State private var prevDirection: FinancesSwipeDirection = .none
    @State private var prevPrevDirection: FinancesSwipeDirection = .none
    
    func determineScrollDirection() {
        guard abs(currentOffset - previousOffset) > 30 else {
            return
        }
        if currentOffset > previousOffset {
            swipeDirection = .down
        } else if currentOffset < previousOffset {
            swipeDirection = .up
        } else {
            swipeDirection = .none
        }
        print("swipeDirection: \(swipeDirection)")
        if prevPrevDirection == swipeDirection {
            if swipeDirection != .none {
                onSwipe(swipeDirection)
            }
        }
        previousOffset = currentOffset
        prevPrevDirection = prevDirection
        prevDirection = swipeDirection
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(0..<20) { item in
                    Text("List Item \(item)")
                        .padding()
                }
            }
            .padding()
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onChange(of: geo.frame(in: .global).minY) { newValue in
                            currentOffset = newValue
                            determineScrollDirection()
                            //print("Scroll offset: \(currentOffset)")
                        }
                }
            )
        }
    }
}

/// A simple class that will be useful to do linear interpolation calculations for our Dynmaic Tab Animation
class FinancesLinearInterpolation {
    private var length: Int
    private var inputRange: [CGFloat]
    private var outputRange: [CGFloat]
    
    init(inputRange: [CGFloat], outputRange: [CGFloat]) {
        /// Safe Check
        assert(inputRange.count == outputRange.count)
        self.length = inputRange.count - 1
        self.inputRange = inputRange
        self.outputRange = outputRange
    }
    
    func calculate(for x: CGFloat) -> CGFloat {
        /// If Value less than it's Initial Input Range
        if x <= inputRange[0] { return outputRange[0] }
        
        for index in 1...length {
            let x1 = inputRange[index - 1]
            let x2 = inputRange[index]
            
            let y1 = outputRange[index - 1]
            let y2 = outputRange[index]
            
            /// Linear Interpolation Formula: y1 + ((y2-y1) / (x2-x1)) * (x-x1)
            if x <= inputRange[index] {
                let y = y1 + ((y2-y1) / (x2-x1)) * (x-x1)
                return y
            }
        }
        
        /// If Value Exceeds it's Maximum Input Range
        return outputRange[length]
    }
}

struct FinancesTabsView: View {
    @Binding var tabs: [FinancesTab]
    @Binding var currentTab: FinancesTab
    @Binding var indicatorWidth: CGFloat
    @Binding var indicatorPosition: CGFloat
    @Environment(\.colorScheme) var colorScheme
    
    func updateTabWithRect(tabId: UUID, rect: CGRect) {
        if let index = tabs.firstIndex(where: { $0.id == tabId }) {
            tabs[index].minX = rect.minX
            tabs[index].width = rect.width
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(tabs.indices, id: \.self) { index in // Loop over indices
                let tab = tabs[index] // Get the current tab by index
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.5)) {
                        currentTab = tab
                    }
                }) {
                    HStack {
                        // If it's the first tab (index == 0), you can add specific logic or views here
                        if index == 0 {
                            // Specific view or styling for the first tab
                            Image(systemName: tab.iconName ?? "circle")
                                .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
                        } else {
                            // General view for other tabs
                            if let iconName = tab.iconName {
                                Image(systemName: iconName)
                                    .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
                            } else if let imageName = tab.imageName {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 20) // Adjust the frame as necessary
                            }
                        }
                        
                        if let title = tab.title {
                            Text(title)
                                .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
                                .padding(.leading, tab.iconName != nil || tab.imageName != nil ? 8 : 0) // Add padding if there is an icon/image
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .overlay(
                        GeometryReader { proxy in
                            Color.clear
                                .onAppear {
                                    let rect = proxy.frame(in: .global)
                                    if index == 0 {
                                        indicatorWidth = rect.width
                                        indicatorPosition = rect.minX
                                    }
                                    updateTabWithRect(tabId: tab.id, rect: rect)
                                }
                        }
                    )
                }
            }
        }
        .overlay(
            alignment: .bottomLeading,
            content: {
                Rectangle()
                    .frame(width: indicatorWidth, height: 3)
                    .offset(x: indicatorPosition, y: 10)
                    .animation(
                        .easeInOut(duration: 0.3),
                        value: indicatorPosition + indicatorWidth
                    )
            }
        )
        Divider()
            .frame(height: 10)
            .offset(y: 6)
    }
}

enum FinanceCategory: String, CaseIterable {
    case foryou = "For You"
    case following = "Following"
    case recent = "Most Recent"



    var systemImageName: String {
        switch self {
        case .foryou: return "heart.rectangle"
        case .following: return "person.crop.circle.badge.checkmark"
        case .recent: return "arrow.circlepath"

        }
    }
}

struct FinancesCustomPicker: View {
    @State private var currentTab = FinancesTab.sampleTabs[0]
    @State private var tabs = FinancesTab.sampleTabs
    @State private var isToolbarVisible = true
    @State private var indicatorWidth: CGFloat =  0.0
    @State private var indicatorPosition: CGFloat = 0.0
    @State private var currentCategoryTitle: String = "Portfolio"
    
    @State private var showCalendar: Bool = false
    @State private var currentCategory: FinanceCategory = .foryou
    
    func action1() {
        print("Action 1 selected")
    }
    
    func action2() {
        print("Action 2 selected")
    }
    
    func action3() {
        print("Action 3 selected")
    }
    
    func action4() {
        print("Action 4 selected")
    }
    
    func action5() {
        print("Action 5 selected")
    }
    
    func action6() {
        print("Action 6 selected")
    }
    
    var body: some View {
        VStack(spacing: 0) {
//            if isToolbarVisible {
//                WatchlistsCustomToolbar(showCalendar: $showCalendar)
//                    .padding(.bottom, 10)
//            }
//            
//            
//            if showCalendar {
//                
//                MainCalendarView() // Adjust according to actual requirements
//                    .transition(.move(edge: .top)) // Optional: Add transition for better UI experience
//                    .animation(.default, value: showCalendar) // Optional: Animate the appearance/disappearance
//            }
            
            FinancesTabsView(
                tabs: $tabs,
                currentTab: $currentTab,
                indicatorWidth: $indicatorWidth,
                indicatorPosition: $indicatorPosition
            )
            
            HStack {
                Text(currentCategoryTitle)
                    .font(.headline) // Customize the font as needed
                    .padding(.vertical, 10)
                
//                Picker(selection: $currentCategory, label: EmptyView()) {
//                    ForEach(WatchlistCategory.allCases, id: \.self) { category in
//                        HStack {
//                            Text(category.rawValue)
//                            Spacer()
//                            Image(systemName: category.systemImageName).foregroundColor(.primary)
//                        }.tag(category) // Make sure each option is tagged with its corresponding `WatchlistCategory` value
//                    }
//                }
//                .pickerStyle(MenuPickerStyle())
//                .labelsHidden()
                
                Menu {
                    Menu("Show Graph in Post Preview") {
                        Button(action: action1) {
                            Label("Yes", systemImage: "checkmark.circle")
                        }
                        Button(action: action2) {
                            Label("No", systemImage: "x.circle")
                        }
                    }
                    
                    Menu("More Options") {
                        Button(action: action3) {
                            Label("Follow", systemImage: "person.badge.plus")
                        }
                        Button(action: action4) {
                            Label("Report", systemImage: "flag")
                        }
                        Button(action: action5) {
                            Label("Mute", systemImage: "speaker.slash")
                        }
                        Button(action: action6) {
                            Label("Block", systemImage: "circle.slash")
                        }
                    }
                    
                } label: {
                    Image(systemName: "slider.horizontal.3")
                }
            }
            
            FinancesTabView(
                tabs: $tabs,
                currentTab: $currentTab,
                indicatorWidth: $indicatorWidth,
                indicatorPosition: $indicatorPosition,
                onSwipe: { direction in
                    print("NewView direction: \(direction)")
                    withAnimation(.easeInOut(duration: 0.2)) {
                        isToolbarVisible = (direction == .up) ? false : true
                    }
                }
            )
            // Add the .onChange modifier here to update the category title
            .onChange(of: currentTab) { newTab in
                // Find the index of the newTab in the tabs array
                if let tabIndex = tabs.firstIndex(where: { $0.id == newTab.id }) {
                    // Use the tabIndex in your switch statement
                    switch tabIndex {
                    case 0:
                        currentCategoryTitle = "Portfolio"
                    case 1:
                        currentCategoryTitle = "Wallet"
                    case 2:
                        currentCategoryTitle = "Analytics"
                    case 3:
                        currentCategoryTitle = "Categories:"
                    case 4:
                        currentCategoryTitle = "Disputes:"
                    case 5:
                        currentCategoryTitle = "My Investments:"
                    case 6:
                        currentCategoryTitle = "Saved:"
                    case 7:
                        currentCategoryTitle = "Profiles:"
                    default:
                        currentCategoryTitle = "Other Category:"
                    }
                }
            }
        }
    }
}

extension View {
    func FinancesoffsetX(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .global)
                    
                    Color.clear
                        .preference(key: FinancespickerOffsetKey.self, value: rect)
                        .onPreferenceChange(FinancespickerOffsetKey.self, perform: completion)
                }
            }
    }
    
    func FinancesdetectSwipe(onSwipe: @escaping (FinancesSwipeDirection) -> ()) -> some View {
        self
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let verticalDistance = value.location.y - value.startLocation.y
                        print("MarketTabView verticalDistance: \(verticalDistance)")
                        let swipeThreshold = 5.0
                        if verticalDistance > swipeThreshold {
                            onSwipe(.down)
                        } else if verticalDistance < -swipeThreshold {
                            onSwipe(.up)
                        }
                    }
            )
    }
}

/// Preference Key
struct FinancespickerOffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

#Preview {
    FinancesCustomPicker()
}
