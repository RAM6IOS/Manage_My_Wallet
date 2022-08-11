//
//  TransactionsList.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 3/8/2022.
//

import SwiftUI

struct TransactionsList: View {
    let card: Card
    init(card: Card) {
        self.card = card
        
        fetchRequest = FetchRequest<CardTransaction>(entity: CardTransaction.entity(), sortDescriptors: [
            .init(key: "timestamp", ascending: false)
        ], predicate: .init(format: "card == %@", self.card))
    }
    var fetchRequest: FetchRequest<CardTransaction>
    
    @State private var shouldShowAddTransactionForm = false
    @State private var shouldShowFilterSheet = false
    //@FetchRequest(sortDescriptors: [])private var transaction:FetchedResults<CardTransaction>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            if fetchRequest.wrappedValue.isEmpty {
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
            
            } else{
                HStack{
                    Spacer()
                    Button {
                        shouldShowAddTransactionForm.toggle()
                    } label: {
                        Text("+ Transaction")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(.systemBackground))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color(.label))
                            .cornerRadius(5)
                    }
                    
                    Button {
                        shouldShowFilterSheet.toggle()
                    } label: {
                        HStack {
                            
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filter")
                        }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color(.systemBackground))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background(Color(.label))
                            .cornerRadius(5)
                            .sheet(isPresented: $shouldShowFilterSheet) {
                                FilterSheet { categories in
                                    // how exactly do you perform the filtering???
                                }
                            }
                    }
                    
                    
                }
                .padding(.horizontal)
            ForEach(fetchRequest.wrappedValue){ transactio in
               TransactionCard(transaction: transactio)
                
            }
            }
            
        }
        .fullScreenCover(isPresented: $shouldShowAddTransactionForm) {
           TransactionForm(card: card)
        }
    }
}

struct TransactionsList_Previews: PreviewProvider {
    static let firstCard: Card? = {
        let context =  DataController().container.viewContext
        let request = Card.fetchRequest()
        request.sortDescriptors = [.init(key: "timestamp", ascending: false)]
        return try? context.fetch(request).first
    }()
    static var previews: some View {
        if let card = firstCard {
            TransactionsList(card: card)
        }
    }
}
