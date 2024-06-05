//
//  TabModel.swift
//  market
//
//  Created by Nicholas Nelson on 5/7/24.
//

import Foundation
import SwiftUI

struct TabModel: Identifiable {
    private(set) var id: Tab
    var size: CGSize = .zero
    var minX: CGFloat = .zero
    
    enum Tab: String, CaseIterable {
        case research = "Research"
        case deployment = "Development"
        case analytics = "Analytics"
        case audience = "Audience"
        case privacy = "Privacy"
    }
}
