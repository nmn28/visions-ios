//
//  DateExample.swift
//  market
//
//  Created by Nicholas Nelson on 5/24/24.
//

import SwiftUI

struct DateExample: View {
    /// View Properties
    @State private var date: Date = .now
    var body: some View {
        NavigationStack {
            VStack {
                Text("""
                **DateTF(date: $date)** **{** date in
                    let formatter = DateFormatter()
                    formatter.dateFormat = "dd MMM yy, hh:mm a"
                    return formatter.string(from: date)
                **}**
                """)
                    .font(.system(size: 14))
                    .lineSpacing(11)
                    .padding(15)
                    .background(.bar, in: .rect(cornerRadius: 10))
                    .padding(.bottom, 15)
                    
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
            .navigationTitle("Date Picker TextField")
        }
    }
}

#Preview {
    DateExample()
}
