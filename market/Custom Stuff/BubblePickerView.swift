//
//  BubblePickerView.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import SwiftUI

struct BubblePickerView: View {
    let topics = ["For You", "Popular", "Labs", "Supplements", "Wearables", "Fettle"]
    @State private var selectedTopic: String = "For You"

    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(topics, id: \.self) { topic in
                        TopicBubble(topic: topic, isSelected: selectedTopic == topic)
                            .onTapGesture {
                                selectedTopic = topic
                            }
                    }
                }
                .padding(.horizontal)
            }
//            .padding(.top)
        }
    }
}

struct TopicBubble: View {
    var topic: String
    var isSelected: Bool

    var body: some View {
        Text(topic)
            .font(.subheadline)
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                        .background(isSelected ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(isSelected ? Color.white : Color.black)
                        .cornerRadius(15)
    }
}

struct BubblePickerView_Previews: PreviewProvider {
    static var previews: some View {
        BubblePickerView()
    }
}
