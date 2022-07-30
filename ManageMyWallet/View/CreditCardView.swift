//
//  CreditCardView.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import SwiftUI
import CoreData



struct CreditCardView: View {
    var card : Card?
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(card?.name ?? "")
                .font(.system(size: 24, weight: .semibold))
            HStack {
                let imageName = card?.type?.lowercased() ?? ""
                Image(imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 44)
                    .clipped()
                Spacer()
                Text("Balance: $5,000")
                    .font(.system(size: 18, weight: .semibold))
            }
            Text(card?.number ?? "")
            
            Text("Credit Limit: $\(card?.limit ?? 0 )")
            HStack { Spacer() }
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

    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView()
    }
}
