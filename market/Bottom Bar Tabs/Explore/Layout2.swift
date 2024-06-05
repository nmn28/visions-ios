//
//  Layout2.swift
//  market
//
//  Created by Nicholas Nelson on 4/16/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct Layout2: View {
    var cards: [Card]
    var body: some View {
        
        HStack(spacing: 4){
            
            AnimatedImage(url: URL(string: cards[0].download_url))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: ((width / 3)), height: 125)
                .cornerRadius(4)
                .modifier(ContextModifier(card: cards[0]))
            

            if cards.count >= 2{
                
                AnimatedImage(url: URL(string: cards[1].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width / 3)), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: cards[1]))
            }
            
            if cards.count == 3{
                
                AnimatedImage(url: URL(string: cards[2].download_url))
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: ((width / 3)), height: 125)
                    .cornerRadius(4)
                    .modifier(ContextModifier(card: cards[2]))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct Layout2_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCards = [
            Card(id: "1", download_url: "https://example.com/image1.jpg", author: "Author 1"),
            Card(id: "2", download_url: "https://example.com/image2.jpg", author: "Author 2"),
            Card(id: "3", download_url: "https://example.com/image3.jpg", author: "Author 3")
        ]
        Layout2(cards: sampleCards)
    }
}
