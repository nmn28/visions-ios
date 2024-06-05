//
//  NewIdeaCustomPicker.swift
//  market
//
//  Created by Nicholas Nelson on 12/22/23.
//

import SwiftUI



struct NewActionsTab: Identifiable, Hashable {
    var id: UUID = UUID()
    var title: String?
    var imageName: String?
    var iconName: String?
    var width: CGFloat = 0
    var minX: CGFloat = 0
    
    // Title is same as the Asset Image Name
    static var sampleTabs: [NewActionsTab] = [
        .init(iconName: "circle.grid.2x1"),
        .init(iconName: "chart.xyaxis.line"),
        .init(iconName: "flowchart"),
        .init(iconName: "dollarsign.arrow.circlepath"),
        .init(iconName: "building.columns")
    ]
}




struct NewActionsTabView: View {
   @Binding var tabs: [NewActionsTab]
   @Binding var currentTab: NewActionsTab
   @Binding var indicatorWidth: CGFloat
   @Binding var indicatorPosition: CGFloat
   let onSwipe: (NewActionsSwipeDirection) -> Void
   
   @State private var contentOffset: CGFloat = 0
   @State private var reloadToggle = false
   
    @State private var postBody = ""
    @State private var headlineText = ""
    @State private var showingImagePicker = false
    @State private var selectedImage: UIImage?
    @FocusState private var focusPostEditor: Bool
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
       
       let widthInterpolation = NewActionsLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForWidth)
       let positionInterpolation = NewActionsLinearInterpolation(inputRange: inputRange, outputRange: outputRangeForPosition)
       
       indicatorWidth = widthInterpolation.calculate(for: -contentOffset)
       indicatorPosition = positionInterpolation.calculate(for: -contentOffset)
   }
   
   func index(of tab: NewActionsTab) -> Int {
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
                       newBinaryView
                           .frame(width: geometry.size.width, height: geometry.size.height)
                   case 1:
                       newPredictionView
                           .frame(width: geometry.size.width, height: geometry.size.height)
                       // Add more cases as needed for additional tabs
                   case 2:
                       newCategoryView
                           .frame(width: geometry.size.width, height: geometry.size.height)
                   case 3:
                       newTransactionView
                           .frame(width: geometry.size.width, height: geometry.size.height)
                   case 4:
                       newDepositorWithdrawalView
                   
                   default:
                       Text("Tab \(index + 1)")
                           .frame(width: geometry.size.width, height: geometry.size.height)
                   }
               }
               .clipped()
               .ignoresSafeArea()
               .NewActionsoffsetX { rect in
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
       .NewActionsdetectSwipe(
           onSwipe: { direction in
               onSwipe(direction)
           }
       )
   }
    
    private var newBinaryView: some View {
        ScrollView {
            Text ("New Binary Event")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("What do you see that others don't?", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "calendar", action: {
                        // action for paperplane
                    })
                    TextField("by When?", text: $headlineText)
                    
//                    DateTF(date: $date) { date in
//                        let formatter = DateFormatter()
//                        formatter.dateFormat = "dd MMM yy, hh:mm a"
//                        return formatter.string(from: date)
//                    }
//                    .padding(.horizontal, 15)
//                    .padding(.vertical, 10)
//                    .frame(width: 200)
//                    .background(.bar, in: .rect(cornerRadius: 10))
                    
                }
                HStack {
                    IconButton(iconName: "pencil", action: {
                        // action for paperplane
                    })
                    TextField("Rationale", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newPredictionView: some View {
        ScrollView {
            Text ("New Prediction")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("Headline", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "calendar", action: {
                        // action for paperplane
                    })
                    TextField("by When?", text: $headlineText)
                }
//                HStack {
//                    IconButton(iconName: "storefront", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Category? (optional)", text: $headlineText)
//                }
//                HStack {
//                    IconButton(iconName: "person.3", action: {
//                        // action for paperplane
//                    })
//                    TextField("Add to a Conference? (optional)", text: $headlineText)
//                }
                HStack {
                    IconButton(iconName: "pencil", action: {
                        // action for paperplane
                    })
                    TextField("Rationale", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newCategoryView: some View {
        ScrollView {
            Text ("New Category")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "storefront", action: {
                        // action for paperplane
                    })
                    TextField("New Category Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newEventView: some View {
        ScrollView {
            Text ("New Event")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    Text("Regular")
                    Spacer()
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    Text("Escrow")
                    Spacer()
                }
                
                HStack {
                    IconButton(iconName: "calendar.badge.plus", action: {
                        // action for paperplane
                    })
                    TextField("New Event Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "clock", action: {
                        // action for paperplane
                    })
                    TextField("Open Until", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newConferenceView: some View {
        ScrollView {
            Text ("New Conference")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "person.badge.plus", action: {
                        // action for paperplane
                    })
                    TextField("Add Members", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("Conference Title", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Description", text: $postBody)
                        .focused($focusPostEditor)
                }
               
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newTransactionView: some View {
        ScrollView {
            Text ("New Transaction")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "person", action: {
                        // action for paperplane
                    })
                    TextField("Name, Username or Email", text: $postBody)
                        .focused($focusPostEditor)
                }
                HStack {
                    IconButton(iconName: "arrow.down", action: {
                        // action for paperplane
                    })
                    TextField("Request", text: $headlineText)
                    Spacer()
                    IconButton(iconName: "arrow.up", action: {
                        // action for paperplane
                    })
                    TextField("Send", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "dollarsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $postBody)
                        .focused($focusPostEditor)
                    Spacer()
                    
                }
                HStack {
                    IconButton(iconName: "bitcoinsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $headlineText)
                }
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Leave a note", text: $postBody)
                        .focused($focusPostEditor)
                }
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var newDepositorWithdrawalView: some View {
        ScrollView {
            Text ("New Deposit or Withdrawal")
                .padding(.vertical, 2)
                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "plus.circle", action: {
                        // action for paperplane
                    })
                    TextField("Deposit", text: $headlineText)
                    Spacer()
                    IconButton(iconName: "banknote", action: {
                        // action for paperplane
                    })
                    TextField("Withdraw", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "building.columns", action: {
                        // action for paperplane
                    })
                    TextField("Bank Account", text: $postBody)
                        .focused($focusPostEditor)
                }
                
                HStack {
                    IconButton(iconName: "creditcard", action: {
                        // action for paperplane
                    })
                    TextField("Choose Card", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "dollarsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $postBody)
                        .focused($focusPostEditor)
                    Spacer()
                }
                
                HStack {
                    IconButton(iconName: "bitcoinsign", action: {
                        // action for paperplane
                    })
                    TextField("0.00", text: $headlineText)
                }
                
                HStack {
                    IconButton(iconName: "note.text", action: {
                        // action for paperplane
                    })
                    TextField("Describe the Deposit (optional)", text: $postBody)
                        .focused($focusPostEditor)
                }
                
                if let postImage = selectedImage {
                    Image(uiImage: postImage)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: .infinity)
                }
            }
            .padding(.horizontal)
        }
    }
}

enum NewActionsSwipeDirection {
   case up, down, left, right, none
}

struct NewActionsListView: View {
   let onSwipe: (NewActionsSwipeDirection) -> Void
   @State private var previousOffset: CGFloat = 0
   @State private var currentOffset: CGFloat = 0
   @State private var swipeDirection: NewActionsSwipeDirection = .none
   @State private var prevDirection: NewActionsSwipeDirection = .none
   @State private var prevPrevDirection: NewActionsSwipeDirection = .none
   
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
class NewActionsLinearInterpolation {
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

struct NewActionsTabsView: View {
   @Binding var tabs: [NewActionsTab]
   @Binding var currentTab: NewActionsTab
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

enum NewActionCategory: String, CaseIterable {
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

struct NewActionsCustomPicker: View {
   @State private var currentTab = NewActionsTab.sampleTabs[0]
   @State private var tabs = NewActionsTab.sampleTabs
   @State private var isToolbarVisible = true
   @State private var indicatorWidth: CGFloat =  0.0
   @State private var indicatorPosition: CGFloat = 0.0
   @State private var currentCategoryTitle: String = "Binary Option"
   
   @State private var showCalendar: Bool = false
   @State private var currentCategory: NewActionCategory = .foryou
   
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
//           if isToolbarVisible {
//               NewActionsCustomToolbar(showCalendar: $showCalendar)
//                   .padding(.bottom, 10)
//           }
//           
//           
//           if showCalendar {
//               
//               MainCalendarView() // Adjust according to actual requirements
//                   .transition(.move(edge: .top)) // Optional: Add transition for better UI experience
//                   .animation(.default, value: showCalendar) // Optional: Animate the appearance/disappearance
//           }
           
           NewActionsTabsView(
               tabs: $tabs,
               currentTab: $currentTab,
               indicatorWidth: $indicatorWidth,
               indicatorPosition: $indicatorPosition
           )
           
           HStack {
               
               Text(currentCategoryTitle)
                   .font(.headline) // Customize the font as needed
                   .padding(.vertical, 10)
               
//               Picker(selection: $currentCategory, label: EmptyView()) {
//                   ForEach(NewActionCategory.allCases, id: \.self) { category in
//                       HStack {
//                           Text(category.rawValue)
//                           Spacer()
//                           Image(systemName: category.systemImageName).foregroundColor(.primary)
//                       }.tag(category) // Make sure each option is tagged with its corresponding `WatchlistCategory` value
//                   }
//               }
//               .pickerStyle(MenuPickerStyle())
//               .labelsHidden()
//               
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
           
           NewActionsTabView(
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
                       currentCategoryTitle = "Binary Option"
                   case 1:
                       currentCategoryTitle = "Stock Option"
                   case 2:
                       currentCategoryTitle = "Category"
                   case 3:
                       currentCategoryTitle = "Transaction"
                   case 4:
                       currentCategoryTitle = "Deposit or Withdrawal"
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
   func NewActionsoffsetX(completion: @escaping (CGRect) -> ()) -> some View {
       self
           .overlay {
               GeometryReader { proxy in
                   let rect = proxy.frame(in: .global)
                   
                   Color.clear
                       .preference(key: NewActionspickerOffsetKey.self, value: rect)
                       .onPreferenceChange(NewActionspickerOffsetKey.self, perform: completion)
               }
           }
   }
   
   func NewActionsdetectSwipe(onSwipe: @escaping (NewActionsSwipeDirection) -> ()) -> some View {
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
struct NewActionspickerOffsetKey: PreferenceKey {
   static var defaultValue: CGRect = .zero
   
   static func reduce(value: inout CGRect, nextValue: () -> CGRect) {
       value = nextValue()
   }
}

#Preview {
   NewActionsCustomPicker()
}
