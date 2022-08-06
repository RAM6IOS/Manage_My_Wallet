//
//  CreditCardView.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import SwiftUI
import CoreData



struct CreditCardView: View {
    var card : Card
    @Environment(\.managedObjectContext) var moc
    @State private var shouldShowActionSheet = false
    @State private var shouldShowEditForm = false
    @State private var refreshId = UUID()
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Text(card.name ?? "")
                    .font(.system(size: 24, weight: .semibold))
                Spacer()
                Button {
                    shouldShowActionSheet.toggle()
                } label: {
                    Image(systemName: "ellipsis")
                        .font(.system(size: 28, weight: .bold))
                }
                .confirmationDialog("Select a color", isPresented: $shouldShowActionSheet, titleVisibility: .visible) {
                    Button{
                        handleDelete()
                    } label: {
                        Text("Dlita")
                    }
                    Button{
                        shouldShowEditForm.toggle()
                    } label: {
                        Text("Edit")
                    }
                }
            }
            
            HStack {
                let imageName = card.type?.lowercased() ?? ""
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
                    .clipped()
                Spacer()
                Text("Balance: $5,000")
                    .font(.system(size: 18, weight: .semibold))
            }
            
            
            Text(card.number ?? "")
            
            HStack {
                Text("Credit Limit: $\(card.limit)")
                Spacer()
                VStack(alignment: .trailing) {
                    Text("Valid Thru")
                    Text("\(String(format: "%02d", card.month))/\(String(card.year % 2000))")
                }
            }
        }
        .foregroundColor(.white)
        .padding()
        .background(
                    LinearGradient(gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue]), startPoint: .top, endPoint: .bottom)

                )
        .overlay(RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
        )
        .cornerRadius(8)
        .shadow(radius: 5)
        .padding(.horizontal)
        .padding(.top, 8)
        .fullScreenCover(isPresented: $shouldShowEditForm) {
            AddCardForm(card: card)
        }


    }
    private func handleDelete() {
        withAnimation {
            do {
                moc.delete(card)
                try moc.save()
            } catch {
                print("Failed to delete transaction: ", error)
            }
        }
    }
}


