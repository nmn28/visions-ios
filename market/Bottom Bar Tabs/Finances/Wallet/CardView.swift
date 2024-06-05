//
//  CardView.swift
//  market
//
//  Created by Nicholas Nelson on 12/3/23.
//

import SwiftUI

struct CardView: View {

    var progress: CGFloat

    private var isCollapsed: Bool {
        progress > 0.7
    }
    
    private var balance: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        formatter.decimalSeparator = "."
        formatter.groupingSeparator = " "
        
        let number = NSNumber(value: 56112.65)
        let formattedValue = formatter.string(from: number)!
        return "$\(formattedValue)"
    }
    
    var body: some View {
        ZStack {
            Rectangle()
//                .fill(LinearGradient(gradient:
//                                        Gradient(colors: [Color.hex("#2B27F3"), Color.hex("#872AFD")]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .frame(height: 230)
                .scaleEffect(y: 0.3 + (1 - progress) * 0.7)
                .mask {
                    RoundedRectangle(cornerRadius: 16)
                        .frame(height: 69 + (1 - progress) * 140)
                }
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        Text("BALANCE")
                            .tracking(1.5)
//                            .fontRegular(color: Color.white.opacity(0.7), size: 8)
                        
                        Text(balance)
//                            .fontBold(color: .white, size: 24)
                    }
                    
                    Spacer()
                    
                    if !isCollapsed {
                        Image("Visa")
                            .resizable()
                            .frame(width: 60, height: 18)
                            .opacity(1 - max(0, min(1, (progress - 0.6) * 10.0)))
                    } else {
                        HStack(spacing: 12) {
                            fourStars
                            Text("0777")
                        }
//                        .fontBold(color: .white, size: 20)
                        .opacity(max(0, min(1, (progress - 0.7) * 4.0)))
                    }
                }

                Spacer()

                HStack {
                    fourStars
                    Spacer()
                    fourStars
                    Spacer()
                    fourStars
                    Spacer()
                    Text("0777")
                }
                .padding(.horizontal, 5)
//                .fontBold(color: .white, size: 20)
                .opacity(2.0 - progress * 3)

                Spacer()

                HStack {
                    VStack(alignment: .leading) {
                        Text("CARD HOLDER")
                            .tracking(1.5)
//                            .fontRegular(color: Color.white.opacity(0.7), size: 8)

                        Text("TOM HOLLAND")
//                            .fontBold(color: .white, size: 15)
                    }

                    Spacer()

                    VStack(alignment: .leading) {
                        Text("EXPIRES")
                            .tracking(1.5)
//                            .fontRegular(color: Color.white.opacity(0.7), size: 8)

                        Text("11/24")
//                            .fontBold(color: .white, size: 15)
                    }
                }
                .opacity(1.0 - progress * 5)
            }
            .frame(height: 160)
            .padding(.horizontal, 32)
            .offset(y: progress * 60)
        }
        .padding(.horizontal, 20)
//        .shadow(color: Color.hex("#4327F3").opacity(0.6), radius: 16, y: 8)
    }

    var fourStars: some View {
        Text("****")
            .padding(.top, 5)
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(progress: 0) // You can adjust the progress value to see different states of the card
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
