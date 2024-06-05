//
//  ScrollViewReaderExample.swift
//  market
//
//  Created by Nicholas Nelson on 3/20/24.
//

import SwiftUI

struct ScrollViewReaderExample: View {
    var body: some View {
        ScrollViewReader { value in
          ScrollView(.horizontal) {
            HStack {
              ForEach(0..<100) { index in
                Text("Item \(index)")
                  .id(index)
              }
            }
          }
          Button("Scroll to Item 50") {
            withAnimation {
              value.scrollTo(50, anchor: .center)
            }
          }
        }
    }
}

#Preview {
    ScrollViewReaderExample()
}
