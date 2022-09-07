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
    @State var selectedCategories = Set<TransactionCategory>()
    
    @State private var shouldShowAddTransactionForm = false
    @State private var shouldShowFilterSheet = false
    //@FetchRequest(sortDescriptors: [])private var transaction:FetchedResults<CardTransaction>
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        
        VStack{
            if fetchRequest.wrappedValue.isEmpty {
            Text("Get started by adding your first transaction")
                    .foregroundColor(Color.black)
            
            Button {
                shouldShowAddTransactionForm.toggle()
            } label: {
                Text("+ Transaction")
                    .padding(EdgeInsets(top: 10, leading: 14, bottom: 10, trailing: 14))
                    .frame(width: 350, height: 50)
                    .background(Color(.label))
                    .foregroundColor(Color(.systemBackground))
                    .font(.headline)
                    .cornerRadius(20)
            }
            
            } else{
                HStack{
                    Spacer()
                    Button {
                        shouldShowAddTransactionForm.toggle()
                    } label: {
                        Text("+ Transaction")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(Color.white)
                            .padding(.horizontal, 15)
                            .padding(.vertical, 10)
                            .background(Color(.label))
                            .cornerRadius(20)
                    }
                    
                    Button {
                        shouldShowFilterSheet.toggle()
                    } label: {
                        HStack {
                            
                            Image(systemName: "line.horizontal.3.decrease.circle")
                            Text("Filter")
                        }
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 15)
                        .padding(.vertical, 10)
                        .background(Color(.label))
                        .cornerRadius(20)
                            .sheet(isPresented: $shouldShowFilterSheet) {
                                FilterSheet(selectedCategories: selectedCategories) { categories in
                                    
                                    selectedCategories = categories
                                }
                            }
                    }
                    
                    
                }
                .padding(.horizontal)
            ForEach(filterTransactions(selectedCategories: self.selectedCategories)){ transactio in
               TransactionCard(transaction: transactio)
                
            }
            }
            
        }
        .fullScreenCover(isPresented: $shouldShowAddTransactionForm) {
           TransactionForm(card: card)
        }
        
    }
    private func filterTransactions(selectedCategories: Set<TransactionCategory>) -> [CardTransaction] {
        if selectedCategories.isEmpty {
            return Array(fetchRequest.wrappedValue)
        }
        return fetchRequest.wrappedValue.filter { transaction in
            var shouldKeep = false
            if let categories = transaction.categories as? Set<TransactionCategory> {
                categories.forEach({ category in
                    if selectedCategories.contains(category) {
                        shouldKeep = true
                    }
                })
            }
            return shouldKeep
        }
    }
    
    
    struct FilterSheet2: View {
        
        @State var selectedCategories: Set<TransactionCategory>
        let didSaveFilters: (Set<TransactionCategory>) -> ()
        
        @Environment(\.managedObjectContext) private var viewContext

        @FetchRequest(
            sortDescriptors: [NSSortDescriptor(keyPath: \TransactionCategory.timestamp, ascending: false)],
            animation: .default)
        private var categories: FetchedResults<TransactionCategory>
        
    //    @State var selectedCategories = Set<TransactionCategory>()
        
        var body: some View {
            NavigationView {
                Form {
                    ForEach(categories) { category in
                        Button {
                            if selectedCategories.contains(category) {
                                selectedCategories.remove(category)
                            } else {
                                selectedCategories.insert(category)
                            }
                            
                        } label: {
                            HStack(spacing: 12) {
                                if let data = category.colorData, let uiColor = UIColor.color(data: data) {
                                    let color = Color(uiColor)
                                    Spacer()
                                        .frame(width: 30, height: 10)
                                        .background(color)
                                }
                                Text(category.name ?? "")
                                
                                    .foregroundColor(Color(.label))
                                Spacer()
                                
                                if selectedCategories.contains(category) {
                                    Image(systemName: "checkmark")
                                }
                            }
                        }
                    }
                }.navigationTitle("Select filters")
                    .navigationBarItems(trailing: saveButton)
            }
        }
        
        @Environment(\.presentationMode) var presentationMode
        
        private var saveButton: some View {
            Button {
                didSaveFilters(selectedCategories)
                presentationMode.wrappedValue.dismiss()
            } label: {
                Text("Save")
            }

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
