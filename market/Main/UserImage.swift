//
//  UserImage.swift
//  market
//
//  Created by Nicholas Nelson on 1/9/24.
//

import SwiftUI

private extension CGFloat {

  static let statusSize: Self = 16

  static let statusRadius: Self = 4
  static let statusBorder: Self = 4
}

struct UserImage: View {
    let imageName: String
    let isOnline: Bool
    var size: CGFloat  // Add a size parameter

    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)  // Use the size parameter
            .clipShape(Circle())
            .overlay {
                GeometryReader { proxy in
                    Circle()
                        .strokeBorder(Color("color/background"), lineWidth: .statusBorder)
                        .background(Circle().fill(isOnline ? Color("color/onlineStatus") : Color("color/offlineStatus")))
                        .frame(width: .statusSize, height: .statusSize, alignment: .center)
                        .offset(x: proxy.size.width / 2)
                        .rotationEffect(.degrees(45))
                        .offset(x: (proxy.size.width - .statusSize) / 2, y: (proxy.size.height - .statusSize) / 2)
                }
            }
            .aspectRatio(1, contentMode: .fit)
    }
}

struct UserImage_Previews: PreviewProvider {
  static var previews: some View {
    ZStack {
      Color("color/background")
        UserImage(imageName: "placeholder/user", isOnline: true, size: 50)
    }
    .previewLayout(.fixed(width: 60, height: 60))
  }
}
