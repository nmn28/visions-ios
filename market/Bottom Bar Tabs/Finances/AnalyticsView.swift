//
//  AnalyticsView.swift
//  market
//
//  Created by Nicholas Nelson on 1/4/24.
//

import SwiftUI
import Charts

struct AnalyticsView: View {
    var body: some View {
        VStack {
            UserPieChartExample()
                
            HStack {
                VStack (alignment: .leading) {
                   
                        HStack {
                            Image(systemName: "clock")
                            Text("History")
                        }
                        Text("32 Investments")
                        Text("20 Binaries")
                        Text("12 Stocks")
                        Text("41 Transactions")
                    }
                
                Spacer()
                VStack(alignment: .leading) {
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark")
                        Text("Binary W/L Ratio")
                    }
                    Text("8/5")
                }
            }
            .padding()
            
            HStack {
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "chart.xyaxis.line")
                        Text("ROI")
                    }
                    Text("Binaries: 80%")
                    Text("Stocks: 32%")
                }
                Spacer()
                VStack (alignment: .leading){
                    HStack {
                        Image(systemName: "calendar.badge.exclamationmark")
                        Text("Binary W/L Ratio")
                    }
                    Text("8/5")
                }
            }
            .padding()
        }
        
    }
}

struct Product: Identifiable {
    let id = UUID()
    let title: String
    let revenue: Double
}

struct UserPieChartExample: View {
    @State private var products: [Product] = [
        .init(title: "Binaries", revenue: 0.4),
        .init(title: "Predictions", revenue: 0.4),
        .init(title: "Indexes", revenue: 0.2),
        .init(title: "Profiles", revenue: 0.1)
    ]
    
    var body: some View {
        
        Chart(products) { product in
            SectorMark(
                angle: .value(
                    Text(verbatim: product.title),
                    product.revenue
                ),
                innerRadius: .ratio(0.6),
                angularInset: 8
            )
            .foregroundStyle(
                by: .value(
                    Text(verbatim: product.title),
                    product.title
                )
            )
        }
        .frame(width: 180, height: 180)
        .padding()
        Spacer()
    }
}


#Preview {
    AnalyticsView()
}
