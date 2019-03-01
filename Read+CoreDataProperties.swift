//
//  Read+CoreDataProperties.swift
//  
//
//  Created by Axl Zhan on 2019/3/1.
//
//

import Foundation
import CoreData


extension Read {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Read> {
        return NSFetchRequest<Read>(entityName: "Read")
    }

    @NSManaged public var alreadyRead: NSSet?

}

// MARK: Generated accessors for alreadyRead
extension Read {

    @objc(addAlreadyReadObject:)
    @NSManaged public func addToAlreadyRead(_ value: Book)

    @objc(removeAlreadyReadObject:)
    @NSManaged public func removeFromAlreadyRead(_ value: Book)

    @objc(addAlreadyRead:)
    @NSManaged public func addToAlreadyRead(_ values: NSSet)

    @objc(removeAlreadyRead:)
    @NSManaged public func removeFromAlreadyRead(_ values: NSSet)

}
