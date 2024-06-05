//
//  IdeaListRowData.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation

typealias PriceChange = (price: String, change: String)

struct IdeaListRowData {
    
    enum RowType {
        case main
        case search(isSaved: Bool, onButtonTapped: () -> ())
    }
    
    let symbol: String
    let name: String?
    let price: PriceChange?
    let type: RowType
    
}
