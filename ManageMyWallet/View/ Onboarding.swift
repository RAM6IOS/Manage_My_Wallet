//
//   Onboarding.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 6/9/2022.
//

import SwiftUI
import CoreMIDI

struct Onboarding: View {
    @Binding  var ShowOnboarding :Bool
    @State var currentPage = 0
    var body: some View {
        GeometryReader(content: { geometry in
        VStack{
            TabView(selection: $currentPage){
            Text("wallet")
                    .tag(0)
                Text("wallet")
                    .tag(1)
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
                if   currentPage <= 1{
                Button{
                    withAnimation{
                    if currentPage != 2 {
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
        }
        })
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        Onboarding(ShowOnboarding: .constant(true))
    }
}
