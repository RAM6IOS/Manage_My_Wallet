//
//  ManageMyWalletApp.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import SwiftUI

@main
struct ManageMyWalletApp: App {
    @StateObject private var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                //.environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
