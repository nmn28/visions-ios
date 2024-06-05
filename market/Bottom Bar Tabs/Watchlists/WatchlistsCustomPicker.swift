//
//  WatchlistsCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 2/10/24.
//

import SwiftUI

 struct WatchlistsTab: Identifiable, Hashable {
     var id: UUID = UUID()
     var title: String?
     var imageName: String?
     var iconName: String?
     var width: CGFloat = 0
     var minX: CGFloat = 0
     
     // Title is same as the Asset Image Name
     static var sampleTabs: [WatchlistsTab] = [
         .init(iconName: "globe"),
         .init(iconName: "circle.grid.2x1"),
         .init(iconName: "chart.xyaxis.line"),
         .init(iconName: "flowchart"),
         .init(iconName: "hammer"),
         .init(iconName: "banknote"),
         .init(iconName: "folder"),
         .init(iconName: "person")
     ]
 }
 
struct ComplexView: View {
    var onSwipeUp: (() -> Void)?
    var body: some View {
        VStack {
            Text("Complex View")
                .font(.title)
            Image(systemName: "star.fill")
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)
            Button("Click Me") {
                print("Button clicked")
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }
}

struct WatchlistsCustomToolbar: View {
    
    @Binding var showCalendar: Bool
    
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(VStack(alignment: .leading, spacing: -4) {
                    HStack {
                        Image(systemName: "laser.burst")
                            .font(.title2)
                        Text("Visions")
                            .font(.title2)
                    }
//                    Text("Forecast.ai")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                    Text("date")
//                        .font(.title3).fontWeight(.heavy)
//                        .bold()
//                        .foregroundColor(Color(uiColor: .secondaryLabel))
                })
            },
            centerContent: {
                AnyView(Text("").font(.title2)/*.font(.headline)*/)
            },
            rightContent: {
                AnyView(HStack(spacing: 20) {
                    Button(action: {
                        showCalendar.toggle()
                    }) {
                        Image(systemName: "calendar")
                            .imageScale(.large)
//                            .foregroundColor(.blue)
                            .tint(.primary)
                    }
                    Button(action: {
                        
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
//                            .foregroundColor(.blue)
                            .tint(.primary)
                    }
//                    Button(action: {
//                       
//                    }) {
//                        Image(systemName: "menucard")
//                            .imageScale(.large)
////                            .foregroundColor(.blue)
//                            .tint(.primary)
//                    }
                    Button(action: {}, label: {
                        Image("placeholder/user")  // Assuming you have a placeholder image named "pic" in your assets
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 30, height: 30)
                            .clipShape(Circle())
                    })
                })
            }
        )
    }
}

struct WatchlistsTabView: View {
    @Binding var tabs: [WatchlistsTab]
    @Binding var currentTab: WatchlistsTab
    @Binding var indicatorWidth: CGFloat
    @Binding var indicatorPosition: CGFloat
    let onSwipe: (WatchlistsSwipeDirection) -> Void
    
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
        
        let widthInterpolation = WatchlistsLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
        let positionInterpolation = WatchlistsLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
        
        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
    }
    
    func index(of tab: WatchlistsTab) -> Int {
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
                       AllFeedView(
                            onSwipe: { direction in
                                onSwipe(direction)
                            }
                        )
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    case 1:
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
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        // Add more cases as needed for additional tabs
                    default:
                        Text("Tab \(index + 1)")
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    }
                }
                .clipped()
                .ignoresSafeArea()
                .WatchlistsoffsetX { rect in
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
        .WatchlistsdetectSwipe(
            onSwipe: { direction in
                onSwipe(direction)
            }
        )
    }
}

enum WatchlistsSwipeDirection {
    case up, down, left, right, none
}

struct AllFeedView: View {
    let onSwipe: (WatchlistsSwipeDirection) -> Void
    @State private var previousOffset: CGFloat = 0
    @State private var currentOffset: CGFloat = 0
    @State private var swipeDirection: WatchlistsSwipeDirection = .none
    @State private var prevDirection: WatchlistsSwipeDirection = .none
    @State private var prevPrevDirection: WatchlistsSwipeDirection = .none
    
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
                }
            }
//            .padding()
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
class WatchlistsLinearInterpolation {
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

struct WatchlistsTabsView: View {
    @Binding var tabs: [WatchlistsTab]
    @Binding var currentTab: WatchlistsTab
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

enum WatchlistCategory: String, CaseIterable {
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

struct WatchlistsCustomPicker: View {
    @State private var currentTab = WatchlistsTab.sampleTabs[0]
    @State private var tabs = WatchlistsTab.sampleTabs
    @State private var isToolbarVisible = true
    @State private var indicatorWidth: CGFloat =  0.0
    @State private var indicatorPosition: CGFloat = 0.0
    @State private var currentCategoryTitle: String = "All:"
    
    @State private var showCalendar: Bool = false
    @State private var currentCategory: WatchlistCategory = .foryou
    
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
            if isToolbarVisible {
                WatchlistsCustomToolbar(showCalendar: $showCalendar)
                    .padding(.bottom, 10)
            }
            
            
            if showCalendar {
                
                MainCalendarView(text: MainCalendarView.$searchText, onSearchChanged: { _ in })
                    .transition(.move(edge: .top)) // Optional: Add transition for better UI experience
                    .animation(.default, value: showCalendar) // Optional: Animate the appearance/disappearance
            }
            
            WatchlistsTabsView(
                tabs: $tabs,
                currentTab: $currentTab,
                indicatorWidth: $indicatorWidth,
                indicatorPosition: $indicatorPosition
            )
            
            HStack {
                Text(currentCategoryTitle)
                    .font(.headline) // Customize the font as needed
                    .padding(.vertical, 10)
                
                Picker(selection: $currentCategory, label: EmptyView()) {
                    ForEach(WatchlistCategory.allCases, id: \.self) { category in
                        HStack {
                            Text(category.rawValue)
                            Spacer()
                            Image(systemName: category.systemImageName).foregroundColor(.primary)
                        }.tag(category) // Make sure each option is tagged with its corresponding `WatchlistCategory` value
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .labelsHidden()
                
                Menu {
                    Button(action: action1) {
                        Label("Custom Watchlist", systemImage: "plus")
                    }
                    Menu("Graph Size in Post Preview") {
                        Button(action: action1) {
                            Label("Large", systemImage: "arrowshape.left")
                        }
                        
                        Button(action: action1) {
                            Label("Small", systemImage: "arrowshape.left.circle")
                        }
                        Button(action: action2) {
                            Label("No graph", systemImage: "x.circle")
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
            
            WatchlistsTabView(
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
                        currentCategoryTitle = "All:"
                    case 1:
                        currentCategoryTitle = "Escrow Options:"
                    case 2:
                        currentCategoryTitle = "Stock Options:"
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
    func WatchlistsoffsetX(completion: @escaping (CGRect) -> ()) -> some View {
        self
            .overlay {
                GeometryReader { proxy in
                    let rect = proxy.frame(in: .global)
                    
                    Color.clear
                        .preference(key: WatchlistspickerOffsetKey.self, value: rect)
                        .onPreferenceChange(WatchlistspickerOffsetKey.self, perform: completion)
                }
            }
    }
    
    func WatchlistsdetectSwipe(onSwipe: @escaping (WatchlistsSwipeDirection) -> ()) -> some View {
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
struct WatchlistspickerOffsetKey: PreferenceKey {
    static var defaultValue: CGRect = .zero
    
    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
        value = nextValue()
    }
}

#Preview {
    WatchlistsCustomPicker()
}
