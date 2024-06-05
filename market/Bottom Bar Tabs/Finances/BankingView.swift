//
//  BankingView.swift
//  market
//
//  Created by Nicholas Nelson on 2/3/24.
//

import SwiftUI
import ScalingHeaderScrollView

struct BankingView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var progress: CGFloat = 0
    @State private var isloading = false
    @State private var showingAddCardView = false
    let service = BankingService()
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        VStack {
            Button(action: {
                showingAddCardView = true
            }) {
                Image(systemName: "plus")
                    .resizable()
                    .frame(width: 24, height: 24)
            }
            .sheet(isPresented: $showingAddCardView) {
                AddCardView()
            }
            ZStack {
                ScalingHeaderScrollView {
                    ZStack {
                        //                    Color.hex("#EFF3F5").edgesIgnoringSafeArea(.all)
                        CardView(progress: progress)
                        //                        .padding(.top, 130)
                        //                        .padding(.bottom, 40)
                        
                    }
                    
                } content: {
                    Text("Latest Transcations")
                    Color.white.frame(height: 15)
                    
                    ForEach(service.transactions) { transaction in
                        TransactionView(transaction: transaction)
                    }
                    //                Color.white.frame(height: 15)
                }
                .height(min: 110.5, max: 250)
                .collapseProgress($progress)
                .allowsHeaderCollapse()
                .pullToLoadMore(isLoading: $isloading, contentOffset: 50) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        isloading = false
                    }
                }
                //            topButtons
                
                // Overlay to hide transactions
                VStack {
                    Rectangle()
                        .foregroundColor(colorScheme == .dark ? .black : .white)
                    //                                .border(Color.black)
                        .frame(height: 20.5) // Adjust this height to match the top padding of CardView
                    Spacer()
                }
                
                .ignoresSafeArea()
                
                //                        VStack {
                //                            Text("Visa Card")
                ////                                .padding(.top, 63)
                //                            Spacer()
                //                        }
            }
            .ignoresSafeArea()
            
        }
        
        //    private var topButtons: some View {
        //        VStack {
        //            HStack {
        //                Button("", action: { self.presentationMode.wrappedValue.dismiss() })
        //                    .buttonStyle(CircleButtonStyle(imageName: "arrow.backward", background: .white.opacity(0), width: 50, height: 50))
        //                    .padding(.leading, 17)
        //                    .padding(.top, 50)
        //                Spacer()
        //                Button("", action: { print("Info") })
        //                    .buttonStyle(CircleButtonStyle(imageName: "ellipsis", background: .white.opacity(0), width: 50, height: 50))
        //                    .padding(.trailing, 17)
        //                    .padding(.top, 50)
        //            }
        //            Spacer()
        //        }
        //        .ignoresSafeArea()
        //    }
    }
}

struct BankingView_Previews: PreviewProvider {
    static var previews: some View {
        BankingView()
    }
}
