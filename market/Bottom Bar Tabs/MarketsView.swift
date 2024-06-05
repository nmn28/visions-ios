//
//  MarketsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/4/23.
//

import SwiftUI

struct MarketsView: View {
    @Binding var isOpened: Bool
    var body: some View {
        VStack {
            MarketsCustomToolbar(isOpened: $isOpened)
        }
        .navigationTitle("")
    }
}

struct MarketsCustomToolbar: View {
    @Binding var isOpened: Bool
    @EnvironmentObject var viewModel: MainViewModel
    
    var body: some View {
        CustomToolbar(
            leftContent: {
                AnyView(VStack(alignment: .leading, spacing: -4) {
                    Text("Forecast.ai")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                    Text("date")
                        .font(.title3).fontWeight(.heavy)
                        .bold()
                        .foregroundColor(Color(uiColor: .secondaryLabel))
                })
            },
            centerContent: {
                AnyView(Text("Markets").font(.headline))
            },
            rightContent: {
                AnyView(HStack(spacing: 28) {
                    Button(action: {
//                        viewModel.toggleSearchBarVisibility()
                    }) {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        isOpened.toggle()
                    }) {
                        Image(systemName: "menucard")
                            .imageScale(.large)
                            .foregroundColor(.blue)
                    }
                })
            }
        )
    }
}

struct MarketsView_Previews: PreviewProvider {
    @State static var isOpened = false
    static var previews: some View {
        MarketsView(isOpened: $isOpened)
    }
}
