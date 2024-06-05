//
//  ProductDetailView.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import SwiftUI

struct ProductDetailView: View {
    var product: MarketplaceProduct

    var body: some View {
        VStack(spacing: 20) {
            Image(product.image)
                .resizable()
                .scaledToFit()
                .frame(height: 300)
                .cornerRadius(20)

            Text(product.name)
                .font(.title)
                .fontWeight(.bold)

            Text("Sold by: Sweater Shop")
                .font(.subheadline)
                .foregroundColor(.gray)

            Text("$\(product.price)")
                .font(.title2)
                .fontWeight(.bold)

            Text("Description of the product goes here.")
                .padding()
            
            Text("Estimated delivery: 5-10 days")
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle(Text("Product Details"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: productList[0])
    }
}
