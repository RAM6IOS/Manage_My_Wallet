//
//   Onboarding.swift
//  ManageMyWallet
import SwiftUI
import CoreMIDI
struct Onboarding: View {
    @Binding  var ShowOnboarding :Bool
    @State var currentPage = 0
    var body: some View {
        GeometryReader(content: { geometry in
        VStack{
            TabView(selection: $currentPage){
                IntroView(name: "welcome on ManageMyWallet", image: "wallet1", texts: "ManageMyWallet is an app for simple income and expense tracking")
                    .tag(0)
                IntroView(name: "Track your spending", image: "wallet2", texts: "Keep track of your expenses manually")
                    .tag(1)
            }
            if currentPage > 0 {
            Button{
                ShowOnboarding.toggle()
            } label: {
                Text("Gat Started")
                    .frame(width: 350, height: 50)
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
                    .padding()
            }
            }
            HStack{
                if currentPage > 0 {
                    Button{
                        withAnimation{
                        currentPage -= 1
                        }
                    } label: {
                        Image(systemName: "arrow.left")
                            .padding()
                            .foregroundColor(.white)
                            .font(.system(size: 25))
                            .background(Color.green)
                            .clipShape(Circle())
                    }
                }
                Spacer()
                if   currentPage < 1 {
                Button{
                    withAnimation{
                    if currentPage != 1 {
                        currentPage += 1
                    }
                    }
                } label: {
                     Image(systemName: "arrow.right")
                    .padding()
                    .foregroundColor(.white)
                    .font(.system(size: 25))
                    .background(Color.green)
                    .clipShape(Circle())
                }
                }
            }
            .padding(.horizontal)
            .padding(.horizontal)
        }
        })
    }
}
struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(ShowOnboarding: .constant(true))
    }
}
