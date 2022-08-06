//
//  AddCardForm.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import SwiftUI

struct AddCardForm: View {
    
    let card: Card?
    var didAddCard: ((Card) ->())? = nil
    
    init(card: Card? = nil , didAddCard: ((Card) ->())? = nil) {
        
        self.card = card
        self.didAddCard = didAddCard
        _name = State(initialValue: self.card?.name ?? "")
        _cardNumber = State(initialValue: self.card?.number ?? "")
        _cardType = State(initialValue: self.card?.type ?? "Visa")
        
        if let limit = card?.limit {
            _limit = State(initialValue: String(limit))
        }
        
        _month = State(initialValue: Int(self.card?.month ?? 1))
        _year = State(initialValue: Int(self.card?.year ?? Int16(currentYear)))
    }
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var cardNumber = ""
    @State private var limit = ""
    @State private var cardType = "Visa"
    @State private var month = 1
    @State private var year = Calendar.current.component(.year, from: Date())
    let currentYear = Calendar.current.component(.year, from: Date())
    var body: some View {
        NavigationView{
            Form{
        Section(header: Text("Card Info")) {
            TextField("Name", text: $name)
            TextField("Credi Card Number", text: $cardNumber)
                .keyboardType(.numberPad)
            TextField("Credit Limit", text: $limit)
                .keyboardType(.numberPad)
            Picker("Type", selection: $cardType) {
                ForEach(["Visa", "Mastercard", "Discover", "Citibank"], id: \.self) { cardType in
                    Text(String(cardType)).tag(String(cardType))
                }
            }
        }
        
        Section(header: Text("Expiration")) {
            Picker("Month", selection: $month) {
                ForEach(1..<13, id: \.self) { num in
                    Text(String(num)).tag(String(num))
                }
            }
            Picker("Year", selection: $year) {
                ForEach(currentYear..<currentYear + 20, id: \.self) { num in
                    Text(String(num)).tag(String(num))
                }
            }
        }
    }
        .navigationTitle("Add Credit Card")
        .navigationBarItems(leading: Button(action: {
            presentationMode.wrappedValue.dismiss()
        }, label: {
            Text("Cancel")
        }),trailing:
          Button{
            let newcard =  self.card != nil ? self.card! : Card(context: moc)
            newcard.name = name
            newcard.number = cardNumber
            newcard.limit = Int32(limit) ?? 0
            newcard.year = Int16(year)
            newcard.month = Int16(month)
            newcard.type  = cardType
            newcard.timestamp = Date()
            
            try? moc.save()
            didAddCard?(newcard)
            presentationMode.wrappedValue.dismiss()
        } label:{
            Text("Save")
        }
        )
}

    }
}

struct AddCardForm_Previews: PreviewProvider {
    static var previews: some View {
        AddCardForm()
    }
}
