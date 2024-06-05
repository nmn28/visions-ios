//
//  CustomSearchBar.swift
//  market
//
//  Created by Nicholas Nelson on 1/23/24.
//

import SwiftUI

struct CustomSearchBar: View {
    @EnvironmentObject var viewModel: MainViewModel
    @Binding var text: String
    var onSearchChanged: (String) -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .onChange(of: text) { newValue in
                    onSearchChanged(newValue)
                }
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {
                        // Magnifying glass icon on the leading side
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        // Clear button on the trailing side
                        if !text.isEmpty {
                            Button(action: {
                                self.text = ""
                                onSearchChanged("")
                            }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10) // This applies to the entire TextField, adjust as needed
            
            // Cancel button
            Button("Cancel") {
                viewModel.hideSearchBar()
                text = ""  // Clear the text when canceling
                onSearchChanged("")  // Notify about the text change
            }
            .padding(.trailing, 10)
        }
    }
}

struct CustomSearchBar_Previews: PreviewProvider {
    @State static private var searchText = ""
    
    static var previews: some View {
        CustomSearchBar(text: $searchText, onSearchChanged: { _ in })
        .previewLayout(.sizeThatFits)
        .padding()
        .environmentObject(MainViewModel())
    }
}
