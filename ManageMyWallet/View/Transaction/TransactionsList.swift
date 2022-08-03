//
//  TransactionsList.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 3/8/2022.
//

import SwiftUI

struct TransactionsList: View {
    @State private var shouldShowAddTransactionForm = false
    @FetchRequest(sortDescriptors: [])private var transaction:FetchedResults<CardTransaction>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            Text("Get started by adding your first transaction")
            
            Button {
                shouldShowAddTransactionForm.toggle()
            } label: {
                Text("+ Transaction")
                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                    .background(Color(.label))
                    .foregroundColor(Color(.systemBackground))
                    .font(.headline)
                    .cornerRadius(5)
            }
            .fullScreenCover(isPresented: $shouldShowAddTransactionForm) {
               TransactionForm()
            }
            ForEach(transaction){ transactio in
               TransactionCard(transaction: transactio)
                
            }
            
        }
    }
}

struct TransactionsList_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsList()
    }
}
