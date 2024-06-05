//
//  NotificationsView.swift
//  market
//
//  Created by Nicholas Nelson on 12/1/23.
//

import SwiftUI

struct NotificationsView: View {
    @Binding var selectedNotificationsTab: Int
    @Binding var isOpened: Bool
    var body: some View {
        VStack {
            NotificationsCustomPicker(isOpened: $isOpened)
            
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct NotificationsView_Previews: PreviewProvider {
    @State static var selectedNotificationsTab = 0
    @State static var isOpened = false
    static var previews: some View {
        NotificationsView(selectedNotificationsTab: $selectedNotificationsTab, isOpened: $isOpened)
    }
}
