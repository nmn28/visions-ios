//
//  CustomToolbar.swift
//  market
//
//  Created by Nicholas Nelson on 1/21/24.
//

import SwiftUI

struct CustomToolbar: View {
    let leftContent: () -> AnyView
    let centerContent: () -> AnyView
    let rightContent: () -> AnyView
    
    init(@ViewBuilder leftContent: @escaping () -> AnyView, @ViewBuilder centerContent: @escaping () -> AnyView, @ViewBuilder rightContent: @escaping () -> AnyView) {
        self.leftContent = leftContent
        self.centerContent = centerContent
        self.rightContent = rightContent
    }

    var body: some View {
//        VStack {
            HStack {
                leftContent()
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                centerContent()
                    .frame(maxWidth: .infinity, alignment: .center)
                
                rightContent()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .frame(height: 42)
            .background(Color(UIColor.systemBackground))
            .foregroundColor(.primary)
            .padding(.horizontal)
            .padding(.top, -7)
//            CustomDivider()
//        }
    }
}

struct CustomToolbar_Previews: PreviewProvider {
    static var previews: some View {
        CustomToolbar(
            leftContent: {
                AnyView(
                    HStack(spacing: 29) {
                        Button(action: {}) {
                            Image(systemName: "paperplane")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {}) {
                            Image(systemName: "circle")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                )},
            centerContent: {
                AnyView(
                    Text("Title").font(.headline)
                )
            },
            rightContent: {
                AnyView(
                    HStack(spacing: 29) {
                        Button(action: {}) {
                            Image(systemName: "magnifyingglass")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                        Button(action: {}) {
                            Image(systemName: "bell")
                                .imageScale(.large)
                                .foregroundColor(.blue)
                        }
                    }
                )
            }
        )
    }
}
