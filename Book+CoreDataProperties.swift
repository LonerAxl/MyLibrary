//
//  Book+CoreDataProperties.swift
//  
//
//  Created by Axl Zhan on 2019/3/5.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var author: String?
    @NSManaged public var category: String?
    @NSManaged public var image: String?
    @NSManaged public var isbn13: String?
    @NSManaged public var pages: Int16
    @NSManaged public var price: String?
    @NSManaged public var pubdate: String?
    @NSManaged public var publisher: String?
    @NSManaged public var readcount: Int16
    @NSManaged public var readdate: NSDate?
    @NSManaged public var status: String?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var translator: String?
    @NSManaged public var wishdate: NSDate?
    @NSManaged public var buydate: NSDate?

}
