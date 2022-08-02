//
//  TransactionForm.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 2/8/2022.
//

import SwiftUI

struct TransactionForm: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    @State private var name = ""
    @State private var amount = ""
    @State private var date = Date()
    @State private var photoData: Data?
    @State private var shouldPresentPhotoPicker = false
    var body: some View {
        NavigationView{
           Form{
               Section(header: Text("Information")) {
                   TextField("Name", text: $name)
                   TextField("Amount", text: $amount)
                   DatePicker("Date", selection: $date, displayedComponents: .date)
                   
                   NavigationLink(destination: Text("Many").navigationTitle("New Title")) {
                       Text("Many to many")
                   }
               }
               Section("Photo/Receipt"){
                   Button {
                       shouldPresentPhotoPicker.toggle()
                   } label: {
                       Text("Select Photo")
                   }
                   .fullScreenCover(isPresented: $shouldPresentPhotoPicker) {
                       PhotoPickerView(photoData: $photoData)
                       
                   }
                   if let data = photoData, let image = UIImage.init(data: data) {
                       Image(uiImage: image)
                           .resizable()
                           .scaledToFill()
                   }
               }
            }
           .navigationTitle("Add Transaction")
           .navigationBarItems(leading: Button{
               dismiss()
           }label: {
               Text("Cancel")
           }, trailing:Button{
               let transaction = CardTransaction(context: moc)
               transaction.name = name
               transaction.timestamp = date
               transaction.amount = Float(amount) ?? 0
               transaction.photoData = photoData
               try? moc.save()
               dismiss()
           } label: {
               Text("Save")
           })
        }
    }
}

struct TransactionForm_Previews: PreviewProvider {
    static var previews: some View {
        TransactionForm()
    }
}
