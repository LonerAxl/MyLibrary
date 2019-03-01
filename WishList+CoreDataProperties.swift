//
//  WishList+CoreDataProperties.swift
//  
//
//  Created by Axl Zhan on 2019/3/1.
//
//

import Foundation
import CoreData


extension WishList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WishList> {
        return NSFetchRequest<WishList>(entityName: "WishList")
    }

    @NSManaged public var notBuyYet: NSSet?

}

// MARK: Generated accessors for notBuyYet
extension WishList {

    @objc(addNotBuyYetObject:)
    @NSManaged public func addToNotBuyYet(_ value: Book)

    @objc(removeNotBuyYetObject:)
    @NSManaged public func removeFromNotBuyYet(_ value: Book)

    @objc(addNotBuyYet:)
    @NSManaged public func addToNotBuyYet(_ values: NSSet)

    @objc(removeNotBuyYet:)
    @NSManaged public func removeFromNotBuyYet(_ values: NSSet)

}
