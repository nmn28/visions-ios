//
//  Layout1.swift
//  market
//
//  Created by Nicholas Nelson on 4/16/24.
//

import SwiftUI
import SDWebImageSwiftUI

// Width...
// Padding = 30
var width = UIScreen.main.bounds.width - 30
struct Layout1: View {
    var cards: [Card]
    var body: some View {
        
        HStack(spacing: 4){
            
            AnimatedImage(url: URL(string: cards[0].download_url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: (width - (width / 3) + 4), height: 250)
                .cornerRadius(4)
                .modifier(ContextModifier(card: cards[0]))
            
            VStack(spacing: 4){
                
                // 123+123+4 = 250
                if cards.count >= 2{
                    
                    AnimatedImage(url: URL(string: cards[1].download_url))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ((width / 3)), height: 123)
                        .cornerRadius(4)
                        .modifier(ContextModifier(card: cards[1]))
                }
                
                if cards.count == 3{
                    
                    AnimatedImage(url: URL(string: cards[2].download_url))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: ((width / 3)), height: 123)
                        .cornerRadius(4)
                        .modifier(ContextModifier(card: cards[2]))
                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Layout1_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCards = [
            Card(id: "1", download_url: "https://example.com/image1.jpg", author: "Author 1"),
            Card(id: "2", download_url: "https://example.com/image2.jpg", author: "Author 2"),
            Card(id: "3", download_url: "https://example.com/image3.jpg", author: "Author 3")
        ]
        Layout1(cards: sampleCards)
    }
}
