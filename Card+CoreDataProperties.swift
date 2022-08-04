//
//  Card+CoreDataProperties.swift
//  ManageMyWallet
//
//  Created by Bouchedoub Rmazi on 4/8/2022.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var limit: Int32
    @NSManaged public var month: Int16
    @NSManaged public var name: String?
    @NSManaged public var number: String?
    @NSManaged public var timestamp: Date?
    @NSManaged public var type: String?
    @NSManaged public var year: Int16
    @NSManaged public var transactions: NSSet?

}

// MARK: Generated accessors for transactions
extension Card {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: CardTransaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: CardTransaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension Card : Identifiable {

}
