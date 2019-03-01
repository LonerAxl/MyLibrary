//
//  Unread+CoreDataProperties.swift
//  
//
//  Created by Axl Zhan on 2019/3/1.
//
//

import Foundation
import CoreData


extension Unread {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unread> {
        return NSFetchRequest<Unread>(entityName: "Unread")
    }

    @NSManaged public var notReadYet: NSSet?

}

// MARK: Generated accessors for notReadYet
extension Unread {

    @objc(addNotReadYetObject:)
    @NSManaged public func addToNotReadYet(_ value: Book)

    @objc(removeNotReadYetObject:)
    @NSManaged public func removeFromNotReadYet(_ value: Book)

    @objc(addNotReadYet:)
    @NSManaged public func addToNotReadYet(_ values: NSSet)

    @objc(removeNotReadYet:)
    @NSManaged public func removeFromNotReadYet(_ values: NSSet)

}
