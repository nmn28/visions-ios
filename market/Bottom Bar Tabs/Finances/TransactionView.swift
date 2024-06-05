//
//  TransactionView.swift
//  market
//
//  Created by Nicholas Nelson on 2/3/24.
//

import SwiftUI

struct TransactionView: View {
    let transaction: BankTransaction
    
    var body: some View {
        HStack(spacing: 16) {
            
            Image(transaction.iconName)
                .resizable()
                .frame(width: 30, height: 30)
            
            VStack(alignment: .leading) {
                Text(transaction.title)
                    .bold()
//                    .foregroundColor(Color.hex("#0C0C0C"))
//                    .fontRegular(size: 16)
                Text(transaction.category)
                    .foregroundColor(.gray)
                    .font(.subheadline)
//                    .fontRegular(size: 13)
            }
            .frame(height: 46)
            
            Spacer()
            
            Text(" $ \(String(format: "%.2f", transaction.balance))")
//                .foregroundColor(transaction.balance > 0 ? Color.hex("#01B74E") : Color.hex("#0C0C0C"))
//                .fontBold(size: 16)
        }
        .padding(.horizontal, 45)
    }
}

struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionView(transaction: BankTransaction(iconName: "Asos", date: nil, title: "Asos", category: "Сlothes and accessories", balance: -36.67))
    }
}
