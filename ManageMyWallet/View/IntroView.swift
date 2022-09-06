
//  IntroView.swift
//  ManageMyWallet
import SwiftUI
struct IntroView: View {
    @State var name : String
    @State var image: String
    @State var texts : String
    var body: some View {
        VStack{
            VStack{
            Text(name)
                .font(
                        .system(size: 20)
                        .weight(.heavy)
                    )
                .padding(.vertical , 20)
                Text(texts)
                .padding()
            }
            Image(image)
                .resizable()
                .scaledToFit()
                .frame(width: 250, height: 250 )
        }
    }
}


