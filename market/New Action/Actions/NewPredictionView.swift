//
//  NewPredictionView.swift
//  market
//
//  Created by Nicholas Nelson on 5/24/24.
//

import SwiftUI

struct NewPredictionView: View {
    @State private var predictionHeadlineText = ""
    @Binding var date: Date
    @State private var headlineText = ""
    var body: some View {
        ScrollView {
            //            Text ("New Binary Event")
            //                .padding(.vertical, 2)
            //                .underline()
            VStack(alignment: .leading) {
                HStack {
                    IconButton(iconName: "text.line.first.and.arrowtriangle.forward", action: {
                        // action for paperplane
                    })
                    TextField("What do you see that others don't?", text: $predictionHeadlineText)
                }
                HStack {
                    IconButton(iconName: "calendar", action: {
                        // action for paperplane
                    })
                    TextField("by When?", text: $predictionHeadlineText)
                    
                    DateTF(date: $date) { date in
                        let formatter = DateFormatter()
                        formatter.dateFormat = "dd MMM yy, hh:mm a"
                        return formatter.string(from: date)
                    }
                    .padding(.horizontal, 15)
                    .padding(.vertical, 10)
                    .frame(width: 200)
                    .background(.bar, in: .rect(cornerRadius: 10))
                    
                }
                HStack {
                    IconButton(iconName: "mappin.and.ellipse", action: {
                        // action for paperplane
                    })
                    TextField("and Where?", text: $predictionHeadlineText)
                }
                HStack {
                    IconButton(iconName: "barometer", action: {
                        // action for paperplane
                    })
                    Text("Originality Detector")
                    Image(systemName: "questionmark.circle")
                        .font(.subheadline)
//                    TextField("and Where?", text: $predictionHeadlineText)
                }
//                HStack {
//                    IconButton(iconName: "photo.badge.plus", action: {
//                        // action for paperplane
//                    })
//                    TextField("add a Photo", text: $predictionHeadlineText)
//                }
//                HStack {
//                    IconButton(iconName: "pencil", action: {
//                        // action for paperplane
//                    })
//                    TextField("Rationale", text: $postBody)
//                        .focused($focusPostEditor)
//                }
//                if let postImage = selectedImage {
//                    Image(uiImage: postImage)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(maxWidth: .infinity)
//                }
            }
            .padding(.horizontal)
        }
    }
}

@available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, watchOS 10.0, *)
struct NewPredictionView_Previews: PreviewProvider {
    static var previews: some View {
        NewPredictionView(date: .constant(Date()))
    }
}
