//
//  PortfolioView.swift
//  market
//
//  Created by Nicholas Nelson on 12/28/23.
//

import SwiftUI

struct Investment: Identifiable {
    var id = UUID()
    var title: String
    var initialAmount: Double
    var currentValue: Double
    var date: Date
    var creator: User  // The user who posted the investment
    var investor: User? // Optional, the user who invested
}



extension Investment {
    static var sampleInvestments: [Investment] = [
        Investment(
            title: "AI will be president",
            initialAmount: 5000.00,
            currentValue: 15000.00,
            date: Date(),
            creator: User.alice
        ),
        Investment(
            title: "AI Monocle's will be the norm",
            initialAmount: 2000.00,
            currentValue: 2200.00,
            date: Date(),
            creator: User.bob
        ),
        Investment(
            title: "Flying cars",
            initialAmount: 7500.00,
            currentValue: 9500.00,
            date: Date(),
            creator: User.charlie
        )
    ]
}

import SwiftUI
struct PortfolioView: View {
    var investments: [Investment]
    var balance: Double
    var body: some View {
        ScrollView {
            VStack {
                InvestmentGraph(investments: investments)
                    .frame(height: 200)
                    .padding(.horizontal)

                InvestmentsView(balance: totalInvestmentValue(investments: investments), investments: investments)
                    
            }
        }
    }
    
    private func totalInvestmentValue(investments: [Investment]) -> Double {
        investments.reduce(0) { $0 + $1.currentValue }
    }
}

// Date formatter
private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

//struct Investment: Identifiable {
//    var id = UUID()
//    var title: String
//    var amount: Double
//    var date: Date
//}
//
//let sampleInvestments = [
//    Investment(title: "Coffee", amount: 3.50, date: Date()),
//    Investment(title: "Book", amount: 15.20, date: Date()),
//    Investment(title: "Salary", amount: 1200.00, date: Date()),

//]

struct InvestmentsView: View {
    var balance: Double
    var investments: [Investment]
//    var creditCard: CreditCard

    var body: some View {
        VStack {
            HStack {
                Text("Investment Balance:")
                    .font(.headline)
                    .padding(.vertical, 5)
                
                Image(systemName: "info.circle")
                
                Spacer()
            }
            .padding(.horizontal)
            HStack {
                Text("Filter:")
                
                Spacer()
            }
            .padding(.horizontal)
            
            VStack (spacing: 0) {
                ForEach(investments.indices, id: \.self) { index in
                    NavigationLink(destination: InvestmentDetailView(investment: investments[index])) {
                        InvestmentRow(investment: investments[index])
                            .padding(.vertical, 10)
                    }
                    .buttonStyle(PlainButtonStyle()) // Use PlainButtonStyle to avoid blue color of link
                    
                    if index < investments.count - 1 {
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

struct InvestmentRow: View {
    var investment: Investment

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    UserImage(imageName: investment.creator.imageName, isOnline: investment.creator.isOnline, size: 40)
                    Text(investment.title)
                        .font(.headline)
                    Spacer() // Pushes content to the sides, expanding the row
                    
                    Text(String(format: "%.2f", investment.currentValue)) // Display current value
                    Image(systemName: "chevron.right")
                }
                
                Text("\(investment.date, formatter: itemFormatter)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
        }
        .contentShape(Rectangle())
    }
}

struct InvestmentsView_Previews: PreviewProvider {
    static var previews: some View {
        InvestmentsView(balance: 1175.30, investments: Investment.sampleInvestments)
    }
}

struct InvestmentDetailView: View {
    var investment: Investment

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text(investment.title)
                .font(.title)
            
            Text("Initial Amount: \(String(format: "%.2f", investment.initialAmount))")
                .font(.body)
            
            Text("Current Value: \(String(format: "%.2f", investment.currentValue))")
                .font(.body)
            
            Text("Date: \(investment.date, formatter: itemFormatter)")
                .font(.body)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Investment Detail", displayMode: .inline)
    }
}

struct InvestmentDetailView_Previews: PreviewProvider {
    static var previews: some View {
        // Create a sample user specifically for this preview
        let previewUser = User(
            roles: [.creator], // Define the role as needed
            settings: UserSettings(preferredLanguage: "English", notificationsEnabled: true),
            username: "PreviewUser",
            token: "PreviewToken",
            name: "Preview Name",
            bio: "Preview Bio",
            position: "Preview Position",
            imageName: "previewImage",
            isOnline: true
        )
        
        let sampleInvestment = Investment(
            title: "Sample Investment",
            initialAmount: 123.45,
            currentValue: 246.90,
            date: Date(),
            creator: previewUser
        )
       
        InvestmentDetailView(investment: sampleInvestment)
    }
}
struct InvestmentGraph: View {
    var investments: [Investment]
    
    var body: some View {
        // Implementation depends on the chosen charting library
        Text("Graph Placeholder")
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleInvestments = [
            Investment(id: UUID(), title: "AI will be president", initialAmount: 5000.00, currentValue: 15000.00, date: Date(), creator: User.stub),
            Investment(id: UUID(), title: "Green Energy Fund", initialAmount: 2000.00, currentValue: 2200.00, date: Date(), creator: User.stub)
        ]
        PortfolioView(investments: sampleInvestments, balance: 17000.00)
    }
}
