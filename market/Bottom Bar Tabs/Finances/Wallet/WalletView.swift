//
//  WalletView.swift
//  market
//
//  Created by Nicholas Nelson on 12/3/23.
//

import SwiftUI

struct SelectedCreditCardView: View {
    @Binding var creditCard: CreditCard?
    var transactions: [Transaction]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        if let creditCard = creditCard {
            NavigationView {
                ScrollView {
                    VStack {
                        CreditCardView(creditCard: creditCard)
                        //                            .padding(.horizontal)
                        
                        TransactionsView(balance: creditCard.balance, transactions: transactions, creditCard: creditCard)
                        //                            .padding(.top)
                    }
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            Button("Done") {
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                        ToolbarItemGroup(placement: .navigationBarTrailing) {
                            Button(action: {
                                // Action for magnifying glass
                            }) {
                                Image(systemName: "magnifyingglass")
                            }
                            
                            if creditCard.isForecastCash {
                                forecastCashCardMenu()
                            } else {
                                regularCardMenu()
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @ViewBuilder
    private func forecastCashCardMenu() -> some View {
        Menu {
            Button(action: {
                // Action specific to forecastCash card
            }) {
                Label("Add Money", systemImage: "dollarsign.circle")
            }
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Transfer to Bank", systemImage: "arrowshape.turn.up.right")
            }

            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Recurring Payments", systemImage: "clock.arrow.2.circlepath")
            }

            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Card Number", systemImage: "creditcard.and.123")
            }
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Card Details", systemImage: "info.circle")
            }
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Notifications", systemImage: "bell.badge")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
    
    @ViewBuilder
    private func regularCardMenu() -> some View {
        Menu {
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Card Number", systemImage: "creditcard.and.123")
            }
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Card Details", systemImage: "info.circle")
            }
            Button(action: {
                // Another action specific to forecastCash card
            }) {
                Label("Notifications", systemImage: "bell.badge")
            }
        } label: {
            Image(systemName: "ellipsis.circle")
        }
    }
}

struct CreditCardStackView: View {
    var creditCards: [CreditCard]
    
    var body: some View {
        VStack {
            ForEach(0..<creditCards.count, id: \.self) { index in
                CreditCardView(creditCard: creditCards[index])
                    .offset(x: 0, y: CGFloat(index) * 20) // Offset each card slightly
            }
        }
    }
}

struct CreditCardView: View {
    var creditCard: CreditCard
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if creditCard.isForecastCash {
                    HStack (spacing: 1) {
                        Image(systemName: "rays")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        Text("Cash")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                    }
                } else {
                    Text("BANK NAME")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
                Spacer()
                if creditCard.isForecastCash {
                    Text(String(format: "$%.2f", creditCard.balance))
                        .font(.title2)
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "creditcard")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            
            Spacer()
            
            Text(creditCard.cardNumber)
                .font(.title2)
                .foregroundColor(.white)
            
            HStack {
                VStack(alignment: .leading) {
                    Text("CARD HOLDER")
                        .font(.caption)
                        .foregroundColor(.white)
                        .opacity(0.7)
                    Text(creditCard.holderName)
                        .font(.title3)
                        .foregroundColor(.white)
                }
                Spacer()
                VStack(alignment: .leading) {
                    Text("EXPIRES")
                        .font(.caption)
                        .foregroundColor(.white)
                        .opacity(0.7)
                    Text(creditCard.expiryDate ?? "N/A")
                        .font(.title3)
                        .foregroundColor(.white)
                }
            }
        }
        .padding()
        .background(
            Group {
                if creditCard.isForecastCash {
                    LinearGradient(gradient: Gradient(colors: [Color.gray, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .topLeading, endPoint: .bottomTrailing)
                }
            }
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(creditCard.isForecastCash ? Color.white : Color.clear, lineWidth: 0.5) // White border only for forecastCash card
        )
        .shadow(radius: 10)
        .frame(width: 360, height: 190)
        .padding(.vertical)// Adjust width to fit your design
    }
}
// Sample credit card data for preview
struct CreditCard: Identifiable {
    var id = UUID()
    var cardNumber: String
    var holderName: String
    var balance: Double
    var isForecastCash: Bool = false
    var expiryDate: String? // Optional if some cards don't have an expiry date
}
struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView(creditCard: CreditCard(cardNumber: "**** **** **** 1234", holderName: "John Doe", balance: 1175.30))
    }
}

struct Transaction: Identifiable {
    var id = UUID()
    var title: String
    var amount: Double
    var date: Date
}

let sampleTransactions = [
    Transaction(title: "Coffee", amount: 3.50, date: Date()),
    Transaction(title: "Book", amount: 15.20, date: Date()),
    Transaction(title: "Salary", amount: 1200.00, date: Date()),
    // Add more transactions as needed
]

struct TransactionsView: View {
    var balance: Double
    var transactions: [Transaction]
    var creditCard: CreditCard

    var body: some View {
        VStack {
            HStack {
                Text("Transactions")
                    .font(.headline)
                    .padding(.vertical, 5)
                
               
                
                Spacer()
                Image(systemName: "line.3.horizontal.decrease.circle")
                HStack {
                    Text("Filter By:")
                }
            }
            .padding(.horizontal)
            
            VStack (spacing: 0) {
                ForEach(transactions.indices, id: \.self) { index in
                    NavigationLink(destination: TransactionDetailView(transaction: transactions[index])) {
                        TransactionRow(transaction: transactions[index])
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to avoid blue color of link
                    
                    if index < transactions.count - 1 {
                        Divider()
//                            .padding(.leading)
                            .edgesIgnoringSafeArea(.horizontal)
                    }
                }
                .padding(.horizontal)
            }
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal)
        }
    }
}

struct TransactionRow: View {
    var transaction: Transaction
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(transaction.title)
                        .font(.headline)
                    Spacer() // Pushes content to the sides, expanding the row
                    
                    Text(String(format: "%.2f", transaction.amount))
                    
                    Image(systemName: "chevron.right")
                }
                Text("\(transaction.date, formatter: itemFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            
        }
        .contentShape(Rectangle())
    }
}


// Date formatter
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample credit card instance
        let sampleCreditCard = CreditCard(cardNumber: "**** **** **** 1234", holderName: "John Doe", balance: 1175.30)
        // Pass this sample credit card to the TransactionsView
        TransactionsView(balance: 1175.30, transactions: sampleTransactions, creditCard: sampleCreditCard)
    }
}

struct TransactionDetailView: View {
    var transaction: Transaction

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(transaction.title)
                .font(.title)
            
            Text("Amount: \(String(format: "%.2f", transaction.amount))")
                .font(.body)
            
            Text("Date: \(transaction.date, formatter: itemFormatter)")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Transaction Detail", displayMode: .inline)
    }
}

struct TransactionDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample transaction instance for preview purposes
        let sampleTransaction = Transaction(
            id: UUID(),
            title: "Sample Transaction",
            amount: 123.45,
            date: Date()
        )
        
        // Use the sample transaction for the preview
        TransactionDetailView(transaction: sampleTransaction)
    }
}

struct WalletView: View {
    // Assuming forecastCashCard is separated and not included in the creditCards array
    var forecastCashCard = CreditCard(cardNumber: "**** **** **** 0000", holderName: "Your Name", balance: 1000.00, isForecastCash: true, expiryDate: "N/A")
    
    // Your other cards, excluding the forecastCash card
    var creditCards: [CreditCard] = [
        // Example card, add your actual credit cards here
        CreditCard(cardNumber: "1234 5678 9012 3456", holderName: "John Doe", balance: 1000, isForecastCash: false, expiryDate: "12/34"),
        // Add more credit cards as needed
    ]
    
    @State private var selectedCard: CreditCard? = nil
    
    var body: some View {
            ScrollView {
                VStack(spacing: -20) {
                    ForEach([forecastCashCard] + creditCards, id: \.id) { card in
                        CreditCardView(creditCard: card)
                            .zIndex(isSelected(card: card) ? 1 : 0) // Raise z-index if selected
                            .onTapGesture {
                                self.selectedCard = card
                            }
                    }
                }
            }
            .fullScreenCover(item: $selectedCard) { card in
                SelectedCreditCardView(creditCard: .constant(card), transactions: sampleTransactions)
            }
        }
        
        private func isSelected(card: CreditCard) -> Bool {
            return selectedCard?.id == card.id
        }
    }

    struct WalletView_Previews: PreviewProvider {
        static var previews: some View {
            WalletView()
        }
    }


