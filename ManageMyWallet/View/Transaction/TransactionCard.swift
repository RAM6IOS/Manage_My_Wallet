//
//  TransactionCard.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 2/8/2022.
//

import SwiftUI

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .none
    return formatter
}()

struct TransactionCard: View {
    var transaction: CardTransaction
    @State var shouldPresentActionSheet = false
    @Environment(\.managedObjectContext) var moc
    var body: some View {
        VStack{
            HStack{
                VStack(alignment: .leading){
                Text(transaction.name ?? "name")
                    .font(.headline)
                if let date = transaction.timestamp {
                        Text(dateFormatter.string(from: date))
                }
                }
                Spacer()
                VStack(alignment: .trailing){
                    Button{
                        shouldPresentActionSheet.toggle()
                    } label: {
                        Image(systemName: "ellipsis")
                            .font(.system(size: 24))
                    }
                    .padding(EdgeInsets(top: 6, leading: 8, bottom: 4, trailing: 0))
                    .confirmationDialog("Select a color", isPresented: $shouldPresentActionSheet, titleVisibility: .visible) {
                        Button{
                            handleDelete()
                        } label: {
                            Text("Edita")
                        }
                        
                    }
                    Text(String(format: "$%.2f", transaction.amount  ))
                }
            }
            if let photoData = transaction.photoData, let uiImage = UIImage(data: photoData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
            }
        }
        .foregroundColor(Color(.label))
        .padding()
        .background(Color.white)
        .cornerRadius(5)
        .shadow(radius: 5)
        .padding()
    }
    
    private func handleDelete() {
        withAnimation {
            do {
                
                
                moc.delete(transaction)
                
                try moc.save()
            } catch {
                print("Failed to delete transaction: ", error)
            }
        }
    }
}

