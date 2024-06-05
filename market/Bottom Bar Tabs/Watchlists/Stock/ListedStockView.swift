//
//  ListedStockView.swift
//  market
//
//  Created by Nicholas Nelson on 5/3/24.
//

import SwiftUI

// MARK: - ListedPredictionView
struct ListedStockView: View {
    @StateObject var viewModel = StockViewModel()
    @State var showPopup = false
    let stock: Stock
    @ObservedObject private var navBarInfo = NavBarInfo.shared
    
    var body: some View {
        ScrollView {
            NavBarScrollTracker()
            
            VStack {
                Rectangle()
                    .fill(Color.clear)
                    .frame(width: 10, height: navBarInfo.height)
                NavigationView {
                    List(viewModel.stocks) { stock in
                        ListedStockRowView(showPopup: $showPopup, stock: stock)
                            .contentShape(Rectangle())
                            .listRowInsets(EdgeInsets())
                        
                    }
                    .listStyle(.plain)
                }
                .popupNavigationView(horizontalPadding: 40, show: $showPopup) {
                    ScrollView{
                        VStack {
                            VStack {
                                stockUserInfoView(stock: stock)
                                Text(stock.title).font(.headline.bold())
                            }.padding()
                            
                            Text("Your investment will be placed in escrow until the due date. Would you like to confirm?")
                                .padding()
                                .font(.subheadline)
                            
                            Text("Confirm")
                                .padding()
                                .font(.subheadline)
                            // MARK: Your Popup content which will also performs navigations
                            
                        }
                        .navigationTitle("Escrow Investment")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    
                                } label: {
                                    Image(systemName: "plus")
                                }
                            }
                            
                            ToolbarItem(placement: .navigationBarLeading) {
                                Button("Close"){
                                    withAnimation{showPopup.toggle()}
                                }
                            }
                        }
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
        }
    }
        
}
// MARK: - ListedPredictionRowView
struct ListedStockRowView: View {
    @Binding var showPopup: Bool
    let stock: Stock
    let graphData: [Double] = [100.0, 105.0, 103.0, 110.0] // Placeholder for your graph data
    // ellipsis actions
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
        ZStack {
            if !showPopup {
                NavigationLink(destination: ExpandedStockView(stock: stock)) {
                    EmptyView()
                }
                .buttonStyle(PlainButtonStyle())
                .opacity(0)
            }
            VStack {
                StockHeaderView(stock: stock, action1: action1, action2: action2, action3: action3, action4: action4, action5: action5, action6: action6, graphData: graphData)
                
                
                VStack(alignment: .leading, spacing: 5) {
                    
                    
                        Text(stock.body).font(.body)
                        
                        //            // Media Content
                        //            if let media = prediction.media {
                        //                MediaView(media: media)
                        //                    .frame(height: 200)
                        //                    .cornerRadius(8)
                        //                    .padding(.bottom)
                        //            }
                        
                        
                    
                    
//                    if let media = binary.media {
//                            MediaView(media: media)
//                        }
                    
                    
                        
                            HStack {
                                Image(systemName: "bubbles.and.sparkles")
                                Text("Deep Dive (4)")
                                
                            }
                            .font(.subheadline)
                            
                    HStack {
                        CardFooterView()
                        
                        Spacer()
                        HStack (spacing: 20) {
                            Button(action: {
//                                withAnimation {
                                    showPopup.toggle()
//                                }
                            }) {
                                HStack {
                                    Image(systemName: "checkmark.circle")
                                }
                                .foregroundColor(.green)
                            }
                            .onTapGesture {
                                withAnimation {
                                    showPopup.toggle()
                                }
                            }

                            Button(action: {
                                withAnimation {
                                    showPopup.toggle()
                                }
                            }) {
                                HStack {
                                    Image(systemName: "xmark.circle")
                                }
                                .foregroundColor(.red)
                            }
                            .onTapGesture {
                                withAnimation {
                                    showPopup.toggle()
                                }
                            }
                                    }
                                    .imageScale(.large)
                        //                        .font(.system(size: 12))
                    }
                    .padding(.bottom)
                }
                
            }
//            .listRowInsets(EdgeInsets()) // Removes default list row padding
//            .contentShape(Rectangle()) // Ensures the entire area is tappable
            .padding(.horizontal) // Add padding as needed
        }
    }
    struct StockHeaderView: View {
        let stock: Stock
        let action1: () -> Void
        let action2: () -> Void
        let action3: () -> Void
        let action4: () -> Void
        let action5: () -> Void
        let action6: () -> Void
        let graphData: [Double]
        
        var body: some View {
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        stockUserInfoView(stock: stock)
                        Spacer()
                        ActionMenu(action1: action1, action2: action2, action3: action3, action4: action4, action5: action5, action6: action6)
                    }
                    HStack {
                        VStack(alignment: .leading) {
                            stockTitleView(stock: stock)
                            stockHorizontalActionButtons(stock: stock)
                        }
                        Spacer()
                        VStack {
                            stockMiniGraphView(data: graphData)
                                .frame(width: 60)
                            
                            Text(stock.priceChangePercentage)
                                .foregroundColor(stock.priceChangePercentage.hasPrefix("-") ? .red : .green)
                                .font(.subheadline)
                                .padding(.top, -15)
                        }
                        .padding(5)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10) // You can adjust the corner radius here
                                .stroke(Color.primary.opacity(0.2), lineWidth: 1) // Adjust the opacity of the border here
                        )
                    }
                }
                Spacer()
                
            }
        }
    }
}
    // Example of detailed subviews for better structure and navigation handling

    struct stockUserInfoView: View {
        let stock: Stock
        
        var body: some View {
            HStack {
                UserImage(imageName: "placeholder/user", isOnline: true, size: 40)
                VStack (alignment: .leading) {
                    HStack(alignment: .top) {
                        Text(stock.name)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        Text(stock.username)
                            .font(.subheadline)
                            .foregroundColor(Color.gray)
                            .lineLimit(1) // Ensures the text does not wrap
                            .truncationMode(.tail)
                    }
                    
                    HStack (spacing: 5) {
                        HStack (spacing: 3){
                            Image(systemName: "scope")
                            Text("45%")
                        }
                        .font(.caption)
                        
                        HStack (spacing: 3){
                            Image(systemName: "star.circle")
                                .foregroundColor(Color.yellow)
                            
                        }
                        .font(.caption)
                    }
                }
                        Text("· 1h")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Spacer()
                        StockLabel
            }
        }
    }

    struct stockTitleView: View {
        let stock: Stock

        var body: some View {
            Text(stock.title).font(.headline.bold())
        }
    }

    struct stockHorizontalActionButtons: View {
        let stock: Stock

        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    NavigationLink(destination: MainCalendarView(text: MainCalendarView.$searchText, onSearchChanged: { _ in })) {
                        Label("Calendar", systemImage: "calendar")
                    }
                    NavigationLink(destination: MapView()) {
                        Label("Location", systemImage: "mappin.and.ellipse")
                    }
                    // Additional buttons if necessary
                }
                .font(.subheadline)
                .buttonStyle(CapsuleButtonStyle(backgroundColor: Color.gray.opacity(0.5)))

            }
        }
    }

    struct stockActionMenu: View {
        let action1: () -> Void
        let action2: () -> Void
        let action3: () -> Void
        let action4: () -> Void
        let action5: () -> Void
        let action6: () -> Void

        var body: some View {
            Menu {
                Button("Share", action: action1)
                Button("Save", action: action2)
                Button("Follow", action: action3)
                Button("Report", action: action4)
                Button("Mute", action: action5)
                Button("Block", action: action6)
            } label: {
                Image(systemName: "ellipsis.circle")
                    
            }
        }
    }


// MARK: - MiniGraphView
struct stockMiniGraphView: View {
    var data: [Double] // Array of Double to represent your graph data

    var body: some View {
        GeometryReader { geometry in
            Path { path in
                // Draw your graph based on `data`
                let width = geometry.size.width
                let height = geometry.size.height

                path.move(to: CGPoint(x: 0, y: height / 2))
                path.addLine(to: CGPoint(x: width, y: height / 3))
            }
            .stroke(Color.blue, lineWidth: 2)
            .overlay(
                Path { path in
                    let height = geometry.size.height
                    path.move(to: CGPoint(x: 0, y: height / 2))
                    path.addLine(to: CGPoint(x: geometry.size.width, y: height / 2))
                }
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                .foregroundColor(.gray)
            )
        }
        .frame(height: 50) // Set a fixed height for the graph
    }
}
struct stockInteractionIconView: View {
    var iconName: String
    var count: String
    var action: () -> Void // Action for the button
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: iconName)
                Text(count).foregroundColor(.gray)
            }
        }
//        .buttonStyle(.bordered)
    }
}

private var StockLabel: some View {
    Button {
//        dismiss()
    } label: {
        Capsule() // Changed from Circle to Capsule
            .frame(width: 90, height: 26) // Adjust the width and height for capsule shape
            .foregroundColor(.gray.opacity(0.1))
            .overlay {
                HStack {
                    Image(systemName: "chart.xyaxis.line")
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                    Text("stock") // Fixed missing opening parenthesis
                        .font(.system(size: 16, weight: .bold)) // Adjusted for clarity
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
            }
    }
    .buttonStyle(.plain)
}

struct stockCapsuleButtonStyle: ButtonStyle {
    var backgroundColor: Color
    
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.system(size: 12))
            .foregroundColor(Color.primary) // Adapts to light and dark mode
            .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
            .background(Capsule().fill(backgroundColor))
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct stockCardFooterView: View {
//    var commentCount: Int
//    var upvoteCount: Int
//    var viewCount: Int
//    var profileImage: Image
//    var username: String
//    var reshareCount: Int
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                Button(action: {
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "banknote")
                        //                    Text("\(commentCount)")
                        Text("35")
                    }
                }
                
                Button(action: {
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "book")
                        //                    Text("\(viewCount)")
                        Text("1.24k")
                    }
                }
                
                Button(action: {
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "arrow.2.squarepath")
                        //                    Text("\(reshareCount)")
                        Text("16")
                    }
                }
                Button(action: {
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "flame")
                        //                    Text("\(upvoteCount)")
                        Text("35")
                    }
                }
                
                Button(action: {
                }) {
                    HStack(spacing: 5) {
                        Image(systemName: "square.and.arrow.up")
                    }
                }
                
            }
            .font(.system(size: 14))
            .foregroundColor(.primary)
        }
    }
}

// MARK: - MediaView
struct stockMediaView: View {
    let media: MediaType
    
    var body: some View {
        switch media {
        case .photo(let image):
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 200)
                .cornerRadius(8)
                .padding(.bottom)
        case .video(let url):
            Text("Video URL: \(url.absoluteString)")
        case .document(let url):
            Text("Document URL: \(url.absoluteString)")
        }
    }
}

// MARK: - Preview
struct ListedStockView_Previews: PreviewProvider {
    static var previews: some View {
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
    }
}
