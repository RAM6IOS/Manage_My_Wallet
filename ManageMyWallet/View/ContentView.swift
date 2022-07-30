//
//  ContentView.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var shouldPresentAddCardForm = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [])private var cards: FetchedResults<Card>
    var body: some View {
        NavigationView{
            ScrollView{
            if !cards.isEmpty {
                TabView{
                    ForEach(cards) { card in
                        CreditCardView(card: card)
                            .padding(.bottom, 50)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 280)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                }
                Spacer()
                 .fullScreenCover(isPresented: $shouldPresentAddCardForm, onDismiss: nil) {
                    AddCardForm()
                }
            }
            .navigationTitle("Credit Cards")
            .navigationBarItems(trailing:
                Button(action: {
                       shouldPresentAddCardForm.toggle()
                    }, label: {
                        Text("+ Card")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .bold))
                            .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12))
                            .background(Color.black)
                            .cornerRadius(5)
                                    })
                                )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
