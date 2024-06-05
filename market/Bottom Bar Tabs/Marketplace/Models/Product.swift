//
//  Product.swift
//  market
//
//  Created by Nicholas Nelson on 6/4/24.
//

import Foundation

struct MarketplaceProduct: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [MarketplaceProduct(name: "Sleep Stack", image: "sleepstack", price: 54),
                   MarketplaceProduct(name: "Fettle Ring", image: "ring", price: 89),
                   MarketplaceProduct(name: "Basic Metabolic Panel (BMP)", image: "bloodlab", price: 79),
                   MarketplaceProduct(name: "Full Genome Sequence", image: "genome", price: 350),
                   MarketplaceProduct(name: "Fettle Strap", image: "strap", price: 99),
                   MarketplaceProduct(name: "Morning Stack", image: "morningstack", price: 65),
                   MarketplaceProduct(name: "GABA", image: "gaba", price: 54),
                   MarketplaceProduct(name: "Organ Supplements", image: "organs", price: 83)]
