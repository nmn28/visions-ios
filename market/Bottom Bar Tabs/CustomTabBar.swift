//
//  CustomTabBar.swift
//  market
//
//  Created by Nicholas Nelson on 11/27/23.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedNavigationTab: Int
    private let icons = ["eye", "flowchart", "briefcase", "wand.and.stars", "person.3", "bell"]

    var body: some View {
        Spacer()
        CustomDivider()

        HStack {
            ForEach(0..<icons.count, id: \.self) { index in
                TabBarButton(
                    iconName: icons[index],
                    isSelected: selectedNavigationTab == index + 1
                ) {
                    self.selectedNavigationTab = index + 1
                }

                if index < icons.count - 1 {
                    Spacer() // Add a spacer between buttons, but not after the last one
                }
            }
        }
        .padding(.horizontal)
        .frame(height: 38)
    }
}

struct TabBarButton: View {
    var iconName: String
    var isSelected: Bool
    var action: () -> Void
    var hasAlert: Bool = false // Example flag for alerts

    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: iconName)
                    .imageScale(.large)
                    .frame(width: 44, height: 60)
                    .foregroundColor(isSelected ? Color.blue : Color.gray)
//                    .background(isSelected && iconName == "wand.and.stars" ? Color.blue.opacity(0.1) : Color.clear) // Add a background for the wand.and.stars when selected
                    .overlay(
                        // Badge for new alerts
                        hasAlert ? Circle().fill(Color.red).frame(width: 10, height: 10).offset(x: 10, y: -10) : nil
                    )
            }
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedNavigationTab: .constant(1))
    }
}
