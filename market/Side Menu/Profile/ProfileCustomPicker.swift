//
//  ProfileCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 12/21/23.
//

//import SwiftUI
//
// struct ProfileTab: Identifiable, Hashable {
//     var id: UUID = UUID()
//     var title: String?
//     var imageName: String?
//     var iconName: String?
//     var width: CGFloat = 0
//     var minX: CGFloat = 0
//     
//     // Title is same as the Asset Image Name
//     static var sampleTabs: [ProfileTab] = [
//         .init(iconName: "globe"),
//         .init(iconName: "circle.grid.2x1"),
//         .init(iconName: "chart.xyaxis.line"),
//         .init(iconName: "flowchart"),
//         .init(iconName: "hammer"),
//         .init(iconName: "banknote"),
//         .init(iconName: "checkmark.circle"),
//         .init(iconName: "person")
//     ]
// }
// 
//struct ProfileComplexView: View {
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
//
//
//
//struct ProfileTabView: View {
//    @Binding var tabs: [ProfileTab]
//    @Binding var currentTab: ProfileTab
//    @Binding var indicatorWidth: CGFloat
//    @Binding var indicatorPosition: CGFloat
//    let onSwipe: (ProfileSwipeDirection) -> Void
//    
//    @State private var contentOffset: CGFloat = 0
//    @State private var reloadToggle = false
//    
//    /// Calculating Tab Width & Position
//    func updateTabFrame(_ tabViewWidth: CGFloat) {
//        let inputRange = tabs.indices.compactMap { index -> CGFloat? in
//            return CGFloat(index) * tabViewWidth
//        }
//        
//        let outputRangeForWidth = tabs.compactMap { tab -> CGFloat? in
//            return tab.width
//        }
//        
//        let outputRangeForPosition = tabs.compactMap { tab -> CGFloat? in
//            return tab.minX
//        }
//        
//        let widthInterpolation = ProfileLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
//        let positionInterpolation = ProfileLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
//        
//        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
//        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
//    }
//    
//    func index(of tab: ProfileTab) -> Int {
//        return tabs.firstIndex(of: tab) ?? 0
//    }
//    
//    var body: some View {
//        TabView(selection: $currentTab) {
//            ForEach(Array(tabs.enumerated()), id: \.element.id) { index, tab in
//                // Use a GeometryReader to adjust the view based on the tab index
//                GeometryReader { geometry in
//                    // Determine the view to display based on the index
//                    switch index {
//                    case 0:
//                        ProfileListView(
//                            onSwipe: { direction in
//                                onSwipe(direction)
//                            }
//                        )
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                    case 1:
//                        ComplexView()
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                        // Add more cases as needed for additional tabs
//                    default:
//                        Text("Tab \(index + 1)")
//                            .frame(width: geometry.size.width, height: geometry.size.height)
//                    }
//                }
//                .clipped()
//                .ignoresSafeArea()
//                .ProfileoffsetX { rect in
//                    if currentTab.id == tab.id {
//                        contentOffset = rect.minX - (rect.width * CGFloat(self.index(of: tab)))
//                    }
//                    updateTabFrame(rect.width)
//                }
//                .tag(tab)
//            }
//        }
//        .tabViewStyle(.page(indexDisplayMode: .never))
//        .animation(.easeInOut, value: currentTab)
//        .ignoresSafeArea(edges: .bottom)
//        .ProfiledetectSwipe(
//            onSwipe: { direction in
//                onSwipe(direction)
//            }
//        )
//    }
//}
//
//enum ProfileSwipeDirection {
//    case up, down, left, right, none
//}
//
//struct ProfileListView: View {
//    let onSwipe: (ProfileSwipeDirection) -> Void
//    @State private var previousOffset: CGFloat = 0
//    @State private var currentOffset: CGFloat = 0
//    @State private var swipeDirection: ProfileSwipeDirection = .none
//    @State private var prevDirection: ProfileSwipeDirection = .none
//    @State private var prevPrevDirection: ProfileSwipeDirection = .none
//    
//    func determineScrollDirection() {
//        guard abs(currentOffset - previousOffset) > 30 else {
//            return
//        }
//        if currentOffset > previousOffset {
//            swipeDirection = .down
//        } else if currentOffset < previousOffset {
//            swipeDirection = .up
//        } else {
//            swipeDirection = .none
//        }
//        print("swipeDirection: \(swipeDirection)")
//        if prevPrevDirection == swipeDirection {
//            if swipeDirection != .none {
//                onSwipe(swipeDirection)
//            }
//        }
//        previousOffset = currentOffset
//        prevPrevDirection = prevDirection
//        prevDirection = swipeDirection
//    }
//    
//    var body: some View {
//        ScrollView {
//            VStack(spacing: 20) {
//                ForEach(0..<20) { item in
//                    Text("List Item \(item)")
//                        .padding()
//                }
//            }
//            .padding()
//            .background(
//                GeometryReader { geo in
//                    Color.clear
//                        .onChange(of: geo.frame(in: .global).minY) { newValue in
//                            currentOffset = newValue
//                            determineScrollDirection()
//                            //print("Scroll offset: \(currentOffset)")
//                        }
//                }
//            )
//        }
//    }
//}
//
///// A simple class that will be useful to do linear interpolation calculations for our Dynmaic Tab Animation
//class ProfileLinearInterpolation {
//    private var length: Int
//    private var inputRange: [CGFloat]
//    private var outputRange: [CGFloat]
//    
//    init(inputRange: [CGFloat], outputRange: [CGFloat]) {
//        /// Safe Check
//        assert(inputRange.count == outputRange.count)
//        self.length = inputRange.count - 1
//        self.inputRange = inputRange
//        self.outputRange = outputRange
//    }
//    
//    func calculate(for x: CGFloat) -> CGFloat {
//        /// If Value less than it's Initial Input Range
//        if x <= inputRange[0] { return outputRange[0] }
//        
//        for index in 1...length {
//            let x1 = inputRange[index - 1]
//            let x2 = inputRange[index]
//            
//            let y1 = outputRange[index - 1]
//            let y2 = outputRange[index]
//            
//            /// Linear Interpolation Formula: y1 + ((y2-y1) / (x2-x1)) * (x-x1)
//            if x <= inputRange[index] {
//                let y = y1 + ((y2-y1) / (x2-x1)) * (x-x1)
//                return y
//            }
//        }
//        
//        /// If Value Exceeds it's Maximum Input Range
//        return outputRange[length]
//    }
//}
//
//struct ProfileTabsView: View {
//    @Binding var tabs: [ProfileTab]
//    @Binding var currentTab: ProfileTab
//    @Binding var indicatorWidth: CGFloat
//    @Binding var indicatorPosition: CGFloat
//    @Environment(\.colorScheme) var colorScheme
//    
//    func updateTabWithRect(tabId: UUID, rect: CGRect) {
//        if let index = tabs.firstIndex(where: { $0.id == tabId }) {
//            tabs[index].minX = rect.minX
//            tabs[index].width = rect.width
//        }
//    }
//    
//    var body: some View {
//        HStack(spacing: 0) {
//            ForEach(tabs.indices, id: \.self) { index in // Loop over indices
//                let tab = tabs[index] // Get the current tab by index
//                Button(action: {
//                    withAnimation(.easeInOut(duration: 0.5)) {
//                        currentTab = tab
//                    }
//                }) {
//                    HStack {
//                        // If it's the first tab (index == 0), you can add specific logic or views here
//                        if index == 0 {
//                            // Specific view or styling for the first tab
//                            Image(systemName: tab.iconName ?? "circle")
//                                .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
//                        } else {
//                            // General view for other tabs
//                            if let iconName = tab.iconName {
//                                Image(systemName: iconName)
//                                    .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
//                            } else if let imageName = tab.imageName {
//                                Image(imageName)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(height: 20) // Adjust the frame as necessary
//                            }
//                        }
//                        
//                        if let title = tab.title {
//                            Text(title)
//                                .foregroundColor(currentTab.id == tab.id ? (colorScheme == .dark ? .white : .black) : .gray)
//                                .padding(.leading, tab.iconName != nil || tab.imageName != nil ? 8 : 0) // Add padding if there is an icon/image
//                        }
//                    }
//                    .frame(minWidth: 0, maxWidth: .infinity)
//                    .overlay(
//                        GeometryReader { proxy in
//                            Color.clear
//                                .onAppear {
//                                    let rect = proxy.frame(in: .global)
//                                    if index == 0 {
//                                        indicatorWidth = rect.width
//                                        indicatorPosition = rect.minX
//                                    }
//                                    updateTabWithRect(tabId: tab.id, rect: rect)
//                                }
//                        }
//                    )
//                }
//            }
//        }
//        .overlay(
//            alignment: .bottomLeading,
//            content: {
//                Rectangle()
//                    .frame(width: indicatorWidth, height: 3)
//                    .offset(x: indicatorPosition, y: 10)
//                    .animation(
//                        .easeInOut(duration: 0.3),
//                        value: indicatorPosition + indicatorWidth
//                    )
//            }
//        )
//        Divider()
//            .frame(height: 10)
//            .offset(y: 6)
//    }
//}
//
//struct ProfileCustomPicker: View {
//    @State private var currentTab = ProfileTab.sampleTabs[0]
//    @State private var tabs = ProfileTab.sampleTabs
//    @State private var isToolbarVisible = true
//    @State private var indicatorWidth: CGFloat =  0.0
//    @State private var indicatorPosition: CGFloat = 0.0
//    @State private var currentCategoryTitle: String = "All:"
//    @Binding var isOpened: Bool
//    @State private var showCalendar: Bool = false
//   
//    @State private var scrollOffset: CGFloat = 0
//    
//    func action1() {
//        print("Action 1 selected")
//    }
//    
//    func action2() {
//        print("Action 2 selected")
//    }
//    
//    func action3() {
//        print("Action 3 selected")
//    }
//    
//    func action4() {
//        print("Action 4 selected")
//    }
//    
//    func action5() {
//        print("Action 5 selected")
//    }
//    
//    func action6() {
//        print("Action 6 selected")
//    }
//    
//    var body: some View {
//        VStack(spacing: 0) {
////            if isToolbarVisible {
////                ProfileCustomToolbar(isOpened: $isOpened)
////                    .padding(.bottom, 10)
////            }
////        
//            
//            ProfileTabsView(
//                tabs: $tabs,
//                currentTab: $currentTab,
//                indicatorWidth: $indicatorWidth,
//                indicatorPosition: $indicatorPosition
//            )
//            
//            
//            
//            ProfileTabView(
//                tabs: $tabs,
//                currentTab: $currentTab,
//                indicatorWidth: $indicatorWidth,
//                indicatorPosition: $indicatorPosition,
//                onSwipe: { direction in
//                    print("NewView direction: \(direction)")
//                    withAnimation(.easeInOut(duration: 0.2)) {
//                        isToolbarVisible = (direction == .up) ? false : true
//                    }
//                }
//            )
//
//        }
//    }
//}
//
//extension View {
//    func ProfileoffsetX(completion: @escaping (CGRect) -> ()) -> some View {
//        self
//            .overlay {
//                GeometryReader { proxy in
//                    let rect = proxy.frame(in: .global)
//                    
//                    Color.clear
//                        .preference(key: ProfilepickerOffsetKey.self, value: rect)
//                        .onPreferenceChange(ProfilepickerOffsetKey.self, perform: completion)
//                }
//            }
//    }
//    
//    func ProfiledetectSwipe(onSwipe: @escaping (ProfileSwipeDirection) -> ()) -> some View {
//        self
//            .gesture(
//                DragGesture()
//                    .onChanged { value in
//                        let verticalDistance = value.location.y - value.startLocation.y
//                        print("MarketTabView verticalDistance: \(verticalDistance)")
//                        let swipeThreshold = 5.0
//                        if verticalDistance > swipeThreshold {
//                            onSwipe(.down)
//                        } else if verticalDistance < -swipeThreshold {
//                            onSwipe(.up)
//                        }
//                    }
//            )
//    }
//}
//
///// Preference Key
//struct ProfilepickerOffsetKey: PreferenceKey {
//    static var defaultValue: CGRect = .zero
//    
//    static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
//        value = nextValue()
//    }
//}
//
//#Preview {
//    ProfileCustomPicker(isOpened: .constant(false))
//}
