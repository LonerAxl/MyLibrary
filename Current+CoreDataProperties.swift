//
//  Current+CoreDataProperties.swift
//  
//
//  Created by Axl Zhan on 2019/3/1.
//
//

import Foundation
import CoreData


extension Current {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Current> {
        return NSFetchRequest<Current>(entityName: "Current")
    }

    @NSManaged public var currentReading: Book?

}
