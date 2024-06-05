//
//  NewProfileCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 4/27/24.
//

//import SwiftUI
//
//struct TwitterTabView: View {
//    @Binding var scrollViewHeight: CGFloat
//    
//    @State private var tabs = profileTab.twitterTabs
//    @State private var currentTab = profileTab.twitterTabs[0]
//    @State private var indicatorWidth: CGFloat =  0.0
//    @State private var indicatorPosition: CGFloat = 0.0
//    
//    @State private var contentOffset: CGFloat = 0
//    @State private var listHeight: CGFloat = 500
//    @State private var tabBarOffset: CGFloat = 0.0
//    
//    let minDistance = 90.0
//    
//    /// Calculating Tab Width & Position
//    func updateTabFrame(_ tabViewWidth: CGFloat) {
//        let inputRange = tabs.indices.map { index -> CGFloat in
//            return CGFloat(index) * tabViewWidth
//        }
//        let outputRangeForWidth = tabs.map { tab -> CGFloat in
//            return tab.width
//        }
//        let outputRangeForPosition = tabs.map { tab -> CGFloat in
//            return tab.minX
//        }
//        let widthInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
//        let positionInterpolation = LinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
//        
//        indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
//        indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
//    }
//    
//    var staticViewHeight: CGFloat {
//        return scrollViewHeight * 0.7
//    }
//    
//    var body: some View {
//        VStack {
//            TwitterTabBarView(
//                tabs: $tabs,
//                currentTab: $currentTab,
//                tabBarOffset: $tabBarOffset
//            )
//            TabView(selection: $currentTab) {
//                ForEach(tabs.indices, id: \.self) { index in
//                    // Use a GeometryReader to adjust the view based on the tab index
//                    GeometryReader { geometry in
//                        // Determine the view to display based on the index
//                        switch index {
//                        case 0:
//                            TwitterListView()
//                                .frame(width: geometry.size.width)
//                                .background (
//                                    GeometryReader { listGeometry in
//                                        Color.clear
//                                            .onAppear {
//                                                listHeight = listGeometry.size.height
//                                                //print("listGeometry.size: \(listGeometry.size)")
//                                            }
//                                    }
//                                )
//                        case 1:
//                            ComplexView()
//                                .frame(width: geometry.size.width, height: staticViewHeight)
//                                .offset(y: tabBarOffset < minDistance ? -tabBarOffset + minDistance : 0)
//                                //.read(offset: $tabBarOffset)
//                            // Add more cases as needed for additional tabs
//                        default:
//                            Text("Tab \(index + 1)")
//                                .frame(width: geometry.size.width, height: staticViewHeight)
//                                .offset(y: tabBarOffset < minDistance ? -tabBarOffset + minDistance : 0)
//                        }
//                    }
//                    .offsetX { rect in
//                        if currentTab.id == tabs[index].id {
//                            contentOffset = rect.minX - (rect.width * CGFloat(index))
//                        }
//                        updateTabFrame(rect.width)
//                    }
//                    .tag(tabs[index])
//                }
//            }
//            .frame(height: listHeight)
//            .tabViewStyle(.page(indexDisplayMode: .never))
//            .animation(.easeInOut, value: currentTab)
//            .ignoresSafeArea(edges: .bottom)
//            .background(
//                GeometryReader { geo in
//                    Color.clear
//                        .onChange(of: geo.frame(in: .global).minY) { newValue in
//                            let currentOffset = newValue
//                            //print("currentOffset: \(currentOffset)")
//                        }
//                }
//            )
//        }
//    }
//}
//
//#Preview {
//    TwitterTabView(scrollViewHeight: .constant(500.0))
//}
// 
//struct TwitterTabBarView: View {
//    @Binding var tabs: [profileTab]
//    @Binding var currentTab: profileTab
//    @Binding var tabBarOffset: CGFloat
//    
//    @Environment(\.colorScheme) var colorScheme
//    
//    let minDistance = 90.0
//    
//    var body: some View {
//        VStack(spacing: 0) {
//            ScrollView(.horizontal, showsIndicators: false) {
//                HStack(spacing: 0) {
//                    ForEach(tabs) { tab in
//                        profileTabButton(tab: tab, currentTab: $currentTab)
//                    }
//                }
//            }
//            Divider()
//        }
//        .padding(.top, 25)
//        .background(colorScheme == .dark ? Color.black : Color.white)
//        .offset(y: tabBarOffset < minDistance ? -tabBarOffset + minDistance : 0)
//        .read(offset: $tabBarOffset, name: "tabBarOffset")
//        .zIndex(1)
//    }
//}
//
//#Preview {
//    TwitterTabBarView(
//        tabs: .constant(profileTab.twitterTabs),
//        currentTab: .constant(profileTab.twitterTabs[0]),
//        tabBarOffset: .constant(0.0)
//    )
//}
//
//
//// Tab Button...
//struct profileTabButton: View {
//    var tab: profileTab
//    @Binding var currentTab: profileTab
//    //var animation: Namespace.ID = Namespace().wrappedValue
//    
//    var title: String {
//        tab.title ?? ""
//    }
//    
//    var body: some View {
//        Button(
//            action: {
//                withAnimation {
//                    currentTab = tab
//                }
//            },
//            label: {
//                // if i use LazyStack then the text is visible fully in scrollview...
//                // may be its a bug...
//                LazyVStack(spacing: 12) {
//                    Text(title)
//                        .fontWeight(.semibold)
//                        .foregroundColor(currentTab.title == tab.title ? .blue : .gray)
//                        .padding(.horizontal)
//                    if currentTab.title == tab.title {
//                        Capsule()
//                            .fill(Color.blue)
//                            .frame(height: 1.2)
//                            //.matchedGeometryEffect(id: "TAB", in: animation)
//                    } else {
//                        Capsule()
//                            .fill(Color.clear)
//                            .frame(height: 1.2)
//                    }
//                }
//            }
//        )
//    }
//}
//
//#Preview {
//    profileTabButton(
//        tab: Tab.twitterTabs[0],
//        currentTab: .constant(Tab.twitterTabs[0])
//    )
//}
//
//import SwiftUI
//
//struct TwitterListView: View {
//
//    var body: some View {
//        VStack(spacing: 10) {
//            TweetView(
//                tweet: Constants.sampleTweet
//            )
//            Divider()
//            ForEach(1...20, id: \.self) {_ in
//                TweetView(tweet: Constants.sampleText)
//                Divider()
//            }
//        }
//        .padding(.top)
//        .zIndex(0)
//    }
//}
//
//#Preview {
//    TwitterListView()
//}
//
//class LinearInterpolation {
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
//struct profileTab: Identifiable, Hashable {
//    var id: UUID = UUID()
//    var title: String?
//    var imageName: String?
//    var iconName: String?
//    var width: CGFloat = 0
//    var minX: CGFloat = 0
//    
//    // Title is same as the Asset Image Name
//    static var newSampleTabs: [profileTab] = [
//        .init(iconName: "square"),
//        .init(iconName: "triangle"),
//        .init(iconName: "circle"),
//        .init(iconName: "diamond")
//    ]
//    
//    // Title is same as the Asset Image Name
//    static var profileSampleTabs: [profileTab] = [
//        .init(iconName: "globe"),
//        .init(iconName: "circle.grid.2x1"),
//        .init(iconName: "chart.xyaxis.line"),
//        .init(iconName: "flowchart"),
//        .init(iconName: "hammer"),
//        .init(iconName: "banknote"),
//        .init(iconName: "checkmark.circle"),
//        .init(iconName: "person")
//    ]
//
//    static var twitterTabs: [profileTab] = [
//        .init(title: "Tweets"),
//        .init(title: "Tweets & Likes"),
//        .init(title: "Media"),
//        .init(title: "Likes")
//    ]
//}
//
//struct Constants {
//    static let sampleTweet = "New iPhone 12 Purple Review By iJustine 🥳🥳🥳🥳......."
//    static let sampleText = "Lorem ipsum, or lipsum as it is sometimes known, is dummy text used in laying out print, graphic or web designs. The passage is attributed to an unknown typesetter in the 15th century who is thought to have scrambled parts of Cicero's De Finibus Bonorum et Malorum for use in a type specimen book."
//}
//
//
//struct MarketTabBarView: View {
//    @Binding var tabs: [Tab]
//    @Binding var currentTab: Tab
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
//#Preview {
//    MarketTabBarView(
//        tabs: .constant(profileTab.twitterTabs),
//        currentTab: .constant(profileTab.twitterTabs[0]),
//        indicatorWidth: .constant(100.0),
//        indicatorPosition: .constant(0.0)
//    )
//}
//
//
//
////struct NewProfileCustomPicker: View {
////    var body: some View {
////        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
////    }
////}
////
////#Preview {
////    NewProfileCustomPicker()
////}
