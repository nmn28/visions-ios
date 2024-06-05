//
//  CartManager.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [MarketplaceProduct] = []
    @Published private(set) var total: Int = 0
    
    // Payment-related variables
    let paymentHandler = PaymentHandler()
    @Published var paymentSuccess = false
    
    
    // Functions to add and remove from cart
    func addToCart(product: MarketplaceProduct) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: MarketplaceProduct) {
        products = products.filter { $0.id != product.id }
        total -= product.price
    }
    
    // Call the startPayment function from the PaymentHandler. In the completion handler, set the paymentSuccess variable
    func pay() {
        paymentHandler.startPayment(products: products, total: total) { success in
            self.paymentSuccess = success
            self.products = []
            self.total = 0
        }
    }
}
