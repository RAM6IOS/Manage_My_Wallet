//
//  CardTransaction+CoreDataProperties.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 2/8/2022.
//
//

import Foundation
import CoreData


extension CardTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CardTransaction> {
        return NSFetchRequest<CardTransaction>(entityName: "CardTransaction")
    }

    @NSManaged public var amount: Float
    @NSManaged public var name: String?
    @NSManaged public var photoData: Data?
    @NSManaged public var timestamp: Date?

}

extension CardTransaction : Identifiable {

}
