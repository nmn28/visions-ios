//
//  ChartViewData.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import Foundation
import SwiftUI

struct ChartViewData: Identifiable {
    
    let id = UUID()
    let xAxisData: ChartAxisData
    let yAxisData: ChartAxisData
    let items: [ChartViewItem]
    let lineColor: Color
    let previousCloseRuleMarkValue: Double?
    
}

struct ChartViewItem: Identifiable {
    
    let id = UUID()
    let timestamp: Date
    let value: Double
    
}

struct ChartAxisData {
    
    let axisStart: Double
    let axisEnd: Double
    let strideBy: Double
    let map: [String: String]
    
}
