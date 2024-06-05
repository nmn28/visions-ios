//
//  MarketplaceView.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import SwiftUI

struct MarketplaceView: View {
    @StateObject var cartManager = CartManager()
    @State private var searchText = ""
    @State private var isSearchBarVisible = false
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]
    
    var body: some View {
        NavigationView {
            VStack {
                if isSearchBarVisible {
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search", text: $searchText)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .transition(.move(edge: .top))
                            .animation(.spring(), value: isSearchBarVisible)
                    }
                    .padding()
                }

                BubblePickerView()

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(filteredProducts, id: \.id) { product in
                            ProductCard(product: product)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding()
                }
                .navigationTitle(Text("Shop"))
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            withAnimation {
                                isSearchBarVisible.toggle()
                            }
                        }) {
                            Image(systemName: "magnifyingglass")
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            CartView()
                                .environmentObject(cartManager)
                        } label: {
                            CartButton(numberOfProducts: cartManager.products.count)
                        }
                    }
                }
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
    
    var filteredProducts: [MarketplaceProduct] {
        if searchText.isEmpty {
            return productList
        } else {
            return productList.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

#Preview {
    MarketplaceView()
}
