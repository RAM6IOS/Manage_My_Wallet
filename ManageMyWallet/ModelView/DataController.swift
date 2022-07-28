//
//  DataController.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 28/7/2022.
//

import Foundation
import CoreData


class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ManageMyWallet")
    
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
