//
//  ProductCard.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var cartManager: CartManager
    var product: MarketplaceProduct

    var body: some View {
        ZStack(alignment: .topTrailing) {
            NavigationLink(destination: ProductDetailView(product: product)) {
                ZStack(alignment: .bottom) {
                    Image(product.image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)  // Maintain aspect ratio
                        .cornerRadius(20)
                        .frame(width: 180, height: 180)  // Set a fixed height for uniformity

                    VStack(alignment: .leading) {
                        Text(product.name)
                            .bold()

                        Text("\(product.price)$")
                            .font(.caption)
                    }
                    .padding()
                    .frame(width: 180, alignment: .leading)
                    .background(.ultraThinMaterial)
                    .cornerRadius(20)
                }
                .frame(width: 180, height: 250)
                .shadow(radius: 3)
            }

            Button {
                cartManager.addToCart(product: product)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(.black)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

struct ProductCard_Previews: PreviewProvider {
    static var previews: some View {
        ProductCard(product: productList[0])
            .environmentObject(CartManager())
    }
}
