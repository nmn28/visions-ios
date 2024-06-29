//
//  FinancesView.swift
//  market
//
//  Created by Nicholas Nelson on 12/9/23.
//

import SwiftUI

struct FinancesView: View {
    // Sample data for balance, transactions, and portfolio
    let balance: Double = 1234.56
    let recentTransactions: [String] = ["Transaction 1", "Transaction 2"]
    let portfolioSummary: String = "Your Portfolio Summary"
    @Binding var selectedFinancesTab: Int
    @Binding var selectedPortfolioTab: Int
    @Binding var isOpened: Bool
   
    
    var body: some View {
        
            
                VStack {
                    FinancesCustomToolbar(isOpened: $isOpened)
                    // First HStack
                    HStack() {
                        Text("Net Worth:")
                        Text("$500")
                        Spacer()
                        HStack (spacing: 10) {
                            VStack {
                                Button(action: { /* Navigate to Add Cash Details */ }) {
                                    Image(systemName: "plus.circle.fill")
                                        .font(.title2)
                                }
                                
                            }
                            VStack {
                                Button(action: { /* Navigate to Send Cash Details */ }) {
                                    Image(systemName: "minus.circle.fill")
                                        .font(.title2)
                                }
                                
                            }
                            VStack {
                                Button(action: { /* Navigate to Send Cash Details */ }) {
                                    Image(systemName: "arrow.up.circle.fill")
                                        .font(.title2)
                                }
                                
                            }
                            VStack {
                                Button(action: { /* Navigate to Add Recieve Cash Details */ }) {
                                    Image(systemName: "arrow.down.circle.fill")
                                        .font(.title2)
                                }
                                
                            }
                            VStack {
                                Button(action: { /* Navigate to Add Recieve Cash Details */ }) {
                                    Image(systemName: "creditcard.fill")
                                        .font(.title2)
                                }
                                
                            }
                        }
                        
                        
                    }
                    .padding()
                    
                    Spacer()
                                    
                    FinancesCustomPicker()
                    
//                    // Second HStack
//                    HStack (spacing: 23) {
//                        VStack {
//                            Button(action: { /* Navigate to Add Cash Details */ }) {
//                                Image(systemName: "plus.circle.fill")
//                                    .font(.title2)
//                            }
//                            Text("Deposit")
//                                .font(.footnote)
//                        }
//                        VStack {
//                            Button(action: { /* Navigate to Send Cash Details */ }) {
//                                Image(systemName: "minus.circle.fill")
//                                    .font(.title2)
//                            }
//                            Text("Withdraw")
//                                .font(.footnote)
//                        }
//                        VStack {
//                            Button(action: { /* Navigate to Send Cash Details */ }) {
//                                Image(systemName: "arrow.up.circle.fill")
//                                    .font(.title2)
//                            }
//                            Text("Send")
//                                .font(.footnote)
//                        }
//                        VStack {
//                            Button(action: { /* Navigate to Add Recieve Cash Details */ }) {
//                                Image(systemName: "arrow.down.circle.fill")
//                                    .font(.title2)
//                            }
//                            Text("Request")
//                                .font(.footnote)
//                        }
//                        VStack {
//                            Button(action: { /* Navigate to Add Recieve Cash Details */ }) {
//                                Image(systemName: "creditcard.fill")
//                                    .font(.title2)
//                            }
//                            Text("Add Card")
//                                .font(.footnote)
//                        }
//                    }

                    
                }
                .navigationTitle("")
            }
        
        
        
        
    
    struct FinancesCustomToolbar: View {
        @Binding var isOpened: Bool
        var body: some View {
            CustomToolbar(
                leftContent: {
                    AnyView(VStack(alignment: .leading, spacing: -4) {
                        Text("Visions")
                            .font(.title3)
                    })
                },
                centerContent: {
                    AnyView(Text("Finances").font(.headline))
                },
                rightContent: {
                    AnyView(HStack(spacing: 28) {
                        Button(action: {
                            
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
    
}


struct FinancesView_Previews: PreviewProvider {
    @State static var selectedFinancesTab = 0  // Initialized to 0
    @State static var selectedPortfolioTab = 0  // Initialized to 0
    @State static var isOpened = false
    static var previews: some View {
        FinancesView(selectedFinancesTab: $selectedFinancesTab, selectedPortfolioTab: $selectedPortfolioTab, isOpened: $isOpened)
    }
}
