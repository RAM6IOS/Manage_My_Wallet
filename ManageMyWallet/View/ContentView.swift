//
//  ContentView.swift
//  ManageMyWallet
import SwiftUI
struct ContentView: View {
    @State private var shouldPresentAddCardForm = false
    @State private var shouldShowAddTransactionForm = false
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Card.timestamp, ascending: false)],animation: .default)private var cards:FetchedResults<Card>
    @State private var selectedCardHash = -1
    @State var ShowOnboarding = true
    var body: some View {
        NavigationView{
            ScrollView{
            if !cards.isEmpty {
                TabView(selection: $selectedCardHash) {
                    ForEach(cards) { card in
                        CreditCardView(card: card)
                            .padding(.bottom, 50)
                            .tag(card.hash)
                    }
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .frame(height: 280)
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .onAppear {
                self.selectedCardHash = cards.first?.hash ?? -1
               }
                if let firstIndex = cards.firstIndex(where: {$0.hash == selectedCardHash}) {
                    let card = self.cards[firstIndex]
                    TransactionsList(card: card)
                }
            } else{
                VStack {
                    Text("You currently have no cards in the system.")
                        .padding(.horizontal, 48)
                        .padding(.vertical)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.black)
                    Button {
                        shouldPresentAddCardForm.toggle()
                    } label: {
                        Text("+ Add Your First Card")
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(20)
                            .padding()
                    }
                }.font(.system(size: 22, weight: .semibold))
            }
                Spacer()
                 .fullScreenCover(isPresented: $shouldPresentAddCardForm, onDismiss: nil) {
                     AddCardForm(card: nil) { card in
                         self.selectedCardHash = card.hash
                     }
                }
            }
            .fullScreenCover(isPresented:$ShowOnboarding, content: {
                    Onboarding(ShowOnboarding: $ShowOnboarding)
                })
            .navigationTitle("Credit Cards"
            )
            .toolbar {
                ToolbarItem( placement: .navigationBarTrailing) {
                    Button(action: {shouldPresentAddCardForm.toggle()}) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 30))
                    }
                }
            }
            }
        }
    }
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
