//
//  IdeaListRowView.swift
//  market
//
//  Created by Nicholas Nelson on 11/24/23.
//

import SwiftUI

@MainActor
struct IdeaListRowView: View {
    
    var graphData: [Double] // Example data for the graph
    let data: IdeaListRowData
    let exampleGraphData = [100.0, 105.0, 103.0, 110.0]
    
    var body: some View {
        HStack(alignment: .center) {
            if case let .search(isSaved, onButtonTapped) = data.type {
                Button {
                    onButtonTapped()
                } label: {
                    image(isSaved: isSaved)
                }
                .buttonStyle(.plain)
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text(data.symbol).font(.headline.bold())
                if let name = data.name {
                    Text(name)
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                }
            }
            
            Spacer()
            
            MiniGraphView(data: exampleGraphData)
                .frame(width: 60)
                .padding(.horizontal, 5)
            
            if let (price, change) = data.price {
                VStack(alignment: .trailing, spacing: 4) {
                    Text(price)
                    priceChangeView(text: change)
                }
                .font(.headline.bold())
            }
        }
    }
    
    struct MiniGraphView: View {
        var data: [Double] // Array of Double to represent your graph data

        var body: some View {
            GeometryReader { geometry in
                Path { path in
                    // Draw your graph based on `data`
                    // For demonstration, this is a simple line
                    let width = geometry.size.width
                    let height = geometry.size.height

                    // Example of drawing a line - customize this for your data
                    path.move(to: CGPoint(x: 0, y: height / 2))
                    path.addLine(to: CGPoint(x: width, y: height / 3))
                }
                .stroke(Color.blue, lineWidth: 2)
                // Add midline dash
                .overlay(
                    Path { path in
                        let height = geometry.size.height
                        path.move(to: CGPoint(x: 0, y: height / 2))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: height / 2))
                    }
                    .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
                    .foregroundColor(.gray)
                )
            }
            .frame(height: 50) // Set a fixed height for the graph
        }
    }
    
    @ViewBuilder
    func image(isSaved: Bool) -> some View {
        if isSaved {
            Image(systemName: "checkmark.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.white, Color.accentColor)
                .imageScale(.large)
        } else {
            Image(systemName: "plus.circle.fill")
                .symbolRenderingMode(.palette)
                .foregroundStyle(Color.accentColor, Color.secondary.opacity(0.3))
                .imageScale(.large)
        }
    }
    
    @ViewBuilder
    func priceChangeView(text: String) -> some View {
        if case .main = data.type {
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 4)
                    .foregroundColor(text.hasPrefix("-") ? .red : .green)
                    .frame(height: 24)
                
                Text(text)
                    .foregroundColor(.white)
                    .font(.caption.bold())
                    .padding(.horizontal, 8)
            }
            .fixedSize()
        } else {
            Text(text)
                .foregroundColor(text.hasPrefix("-") ? .red : .green)
        }
        
    }
    
}

struct IdeaListRowView_Previews: PreviewProvider {
    static let exampleGraphData = [100.0, 105.0, 103.0, 110.0]
    
    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Main List").font(.largeTitle.bold()).padding()
            VStack {
                IdeaListRowView(graphData: exampleGraphData, data: appleTikcerListRowData(rowType: .main))
                Divider()
                IdeaListRowView(graphData: exampleGraphData, data: teslaTikcerListRowData(rowType: .main))
            }.padding()
            
            Text("Search List").font(.largeTitle.bold()).padding()
            VStack {
                IdeaListRowView(graphData: exampleGraphData, data: appleTikcerListRowData(rowType: .search(isSaved: true, onButtonTapped: {})))
                Divider()
                IdeaListRowView(graphData: exampleGraphData, data: teslaTikcerListRowData(rowType: .search(isSaved: false, onButtonTapped: {})))
            }.padding()
        }.previewLayout(.sizeThatFits)
    }
    
    static func appleTikcerListRowData(rowType: IdeaListRowData.RowType) -> IdeaListRowData {
        .init(symbol: "AAPL", name: "Apple Inc.", price: ("100.0", "+0.7"), type: rowType)
    }
    
    static func teslaTikcerListRowData(rowType: IdeaListRowData.RowType) -> IdeaListRowData {
        .init(symbol: "TSLA", name: "Tesla", price: ("250.9", "-18.5"), type: rowType)
    }
}
