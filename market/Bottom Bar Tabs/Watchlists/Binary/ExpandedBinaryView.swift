//
//  ExpandedBinaryView.swift
//  market
//
//  Created by Nicholas Nelson on 1/18/24.
//

import SwiftUI

// MARK: - ExpandedPredictionView
struct ExpandedBinaryView: View {
    let binary: Binary
    @Environment(\.dismiss) private var dismiss
    @State private var user: User = User.stub
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                binaryHeader
                
//                Divider()
//                    .padding(.vertical, 3)
                
                
//                predictionSymbols
                    
                
                
//                Divider()
//                    .padding(.vertical, 3)
                
//                HStack {
//                    Image(systemName: "doc.richtext")
//                    Image(systemName: "chart.xyaxis.line")
//                    Spacer()
//                    Text("Buy")
//                    Text("Sell")
//                }
//                .padding(.vertical, 1)
//                
//                Divider()
//                    .padding(.vertical, 3)
//                
//                HStack {
//                    Text("Price Change: \(binary.priceChange)")
//                        .foregroundColor(binary.priceChange.hasPrefix("-") ? .red : .green)
//                    
//                    Spacer()
//                    
//                    Text(binary.priceChangePercentage)
//                        .foregroundColor(binary.priceChangePercentage.hasPrefix("-") ? .red : .green)
//                }
//                .font(.headline)
//                
//                
                Divider()
                    .padding(.vertical, 3)
                
//                binaryDeepDive
                
                // Media Content
                if let media = binary.media {
                    MediaView(media: media)
                        .frame(height: 200)
                        .cornerRadius(8)
                        .padding(.bottom)
                }
                
                
                
            }
            .padding()
            .navigationTitle("Username's Prediciton")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
    
    struct CapsuleButtonStyle: ButtonStyle {
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
    
    private var binaryHeader: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                
                
                HStack {
                    UserImage(imageName: user.imageName, isOnline: user.isOnline, size: 50)
                    HStack {
                        Text(binary.name)
                            .font(.subheadline)
                        Text(binary.username)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .truncationMode(.tail)
                    }
                    Text("· 1h ago")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Spacer()
                    
//                    BinaryLabel
                    AddtoWatchlistButton
                    ellipsisButton
                    
                }
                
                HStack {
//                    Text(prediction.title)
//                    Image(systemName: "cricket.ball")
                    Text("AI will be president")
                        .font(.headline)
                    
                }
                
                
                ScrollView (.horizontal) {
                    HStack {
                        Button(action: {
                            MainCalendarView(text: MainCalendarView.$searchText, onSearchChanged: { _ in })
                        }) {
                            HStack {
                                Image(systemName: "calendar")
                                Text("By March 17th, 2029, 4:00 pm (GMT)")
                            }
                        }
                        .buttonStyle(CapsuleButtonStyle(backgroundColor: Color.gray.opacity(0.5)))
                        
                        Button(action: {
                            MapView()
                        }) {
                            HStack {
                                Image(systemName: "mappin.and.ellipse")
                                Text("Capitol Hill, Washington, D.C.")
                            }
                        }
                        .buttonStyle(CapsuleButtonStyle(backgroundColor: Color.gray.opacity(0.5)))
                    }
                }
                
                CardFooterView()
                
                HStack {
                    Button(action: {}) {
                        HStack {
                            Image(systemName: "cpu")
                            Text("Made with forecast.ai")
                        }
                    }
                    .buttonStyle(CapsuleButtonStyle(backgroundColor: Color.gray.opacity(0.5)))
                    
                    Spacer()
                    
                    Button(action: {}) {
                                            HStack {
                                                Image(systemName: "pencil.and.outline")
                                                Text("edited by user")
                                            }
                                        }
                                        .buttonStyle(CapsuleButtonStyle(backgroundColor: Color.gray.opacity(0.5)))
                }
                .font(.subheadline)
                
            }

            
            
        }
    }
    
    private var binaryDeepDive: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                
                HStack {
                    Image(systemName: "bubbles.and.sparkles")
                    Text("Deep Dive (4)")
                    
                }
                
                HStack {
                    Image(systemName: "cricket.ball")
                    Text("We are approaching GPT 5, and it is supposed to be expontentially better than the last model.")
                        
                }
                
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Source (1)")
                }
                
                Image(systemName: "bubbles.and.sparkles")
 
//                // Prediction Body
//                Text(prediction.body)
//                    .font(.body)
//                    .padding(.bottom)
                
                HStack {
                    Image(systemName: "cricket.ball")
                    Text("Politicians are all about saying negative things about each other. AGI will be positive and productive outlooks only.")
                }
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Source (1)")
                }
                Image(systemName: "bubbles.and.sparkles")
                
                
                HStack {
                    Image(systemName: "cricket.ball")
                    Text("It will be way smarter than us, able to tell us our flaws better than anyone else.")
                }
                HStack {
                    Image(systemName: "doc.plaintext")
                    Text("Source (1)")
                }
            }
        }
    }
    
    private var predictionSymbols: some View {
        VStack {
            
            HStack {
                Image(systemName: "banknote")
                Text("48")
                Image(systemName: "book")
                Text("190")
               
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "checkmark.circle")
                        Text("Agree")
                    }
                    .foregroundStyle(.green)
                    HStack {
                        Image(systemName: "x.circle")
                        Text("Disagree")
                    }
                    .foregroundStyle(.red)
                }
                
            }
        }
    }
    
    private var BinaryLabel: some View {
        Button {
            dismiss()
        } label: {
            Capsule() // Changed from Circle to Capsule
                .frame(width: 90, height: 26) // Adjust the width and height for capsule shape
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    HStack {
                        Image(systemName: "circle.grid.2x1")
                            .font(.system(size: 16, weight: .bold))
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                        Text("binary") // Fixed missing opening parenthesis
                            .font(.system(size: 16, weight: .bold)) // Adjusted for clarity
                            .foregroundColor(Color(uiColor: .secondaryLabel))
                    }
                }
        }
        .buttonStyle(.plain)
    }
    
    private var StockLabel: some View {
        Button {
            dismiss()
        } label: {
            Capsule() // Changed from Circle to Capsule
                .frame(width: 00, height: 26) // Adjust the width and height for capsule shape
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
    
    private var ellipsisButton: some View {
        Menu {
            Button(action: action1) {
                Label("Share", systemImage: "square.and.arrow.up")
            }
            Button(action: action2) {
                Label("Save", systemImage: "plus.circle")
            }
            Button(action: action3) {
                Label("Follow User", systemImage: "person.crop.circle.badge.plus")
                    .foregroundColor(.red)
            }
            // ... add more buttons as needed
        } label: {
            Circle()
                .frame(width: 26, height: 26)
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
        }
        .buttonStyle(.plain)
        .menuStyle(.borderlessButton) // Optional: Provides a borderless button style for the menu
    }
    
    struct CardFooterView: View {
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
                            Image(systemName: "arrowshape.turn.up.left")
                            //                    Text("\(upvoteCount)")
                            Text("68")
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
                            Text("42")
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
    
    // Sample actions for menu items
    func action1() {
        print("Action 1 selected")
    }

    func action2() {
        print("Action 2 selected")
    }


    func action3() {
        print("Action 3 selected")
    }

    
    private var AddtoWatchlistButton: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .frame(width: 26, height: 26)
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    Image(systemName: "plus")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
        }
        .buttonStyle(.plain)
    }
    
    private var closeButton: some View {
        Button {
            dismiss()
        } label: {
            Circle()
                .frame(width: 36, height: 36)
                .foregroundColor(.gray.opacity(0.1))
                .overlay {
                    Image(systemName: "xmark")
                        .font(.system(size: 18).bold())
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
        }
        .buttonStyle(.plain)
    }
}

//// MARK: - MediaView
//struct MediaView: View {
//    let media: MediaType
//    
//    var body: some View {
//        switch media {
//        case .photo(let image):
//            image
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//        case .video(let url), .document(let url):
//            Text("Media URL: \(url.absoluteString)")
//                // Here you can add your custom view to handle video or document
//        }
//    }
//}

// MARK: - Preview
struct ExpandedBinaryView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleBinary = Binary(
            name: "Jane Doe",
            username: "@jane_doe",
            title: "Sample Prediction Title",
            body: "This is a detailed description of the prediction. It can be several lines long.",
            media: .photo(Image("sampleImage")), // Replace "sampleImage" with your image asset
            priceChange: "+$2.50",
            priceChangePercentage: "+1.25%"
        )
        
        ExpandedBinaryView(binary: sampleBinary)
    }
}
