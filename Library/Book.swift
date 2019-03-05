//
//  Book.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/1.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON
import CoreData
enum readStatus:String,Codable {
    case read = "read"
    case unread = "unread"
    case wishList = "wishlist"
    case current = "current"
}

class BookHelper: NSObject{
    var author:String?
    var category:String?
    var image:String?
    var isbn13:String?
    var price:String?
    var publisher:String?
    var readcount:Int?
    var readdate:Date?
    var status:readStatus?
    var summary:String?
    var title:String?
    var translator:String?
    var pages:String?
    var pubdate:String?
    var wishdate:Date?
    var buydate:Date?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override init() {
        super.init()
    }
    
    init(data:Data, readdate: Date?, status: readStatus?, readcount: Int?, wishdate: Date?, buydate: Date?) {
        var Json = JSON()
        do {
            Json = try JSON.init(data: data)
        } catch {
            print("\(error)")
        }
        author = Json["author"][0].string
        image = Json["image"].string
        translator = Json["translator"][0].string
        pages = Json["pages"].string
        publisher = Json["publisher"].string
        isbn13 = Json["isbn13"].string
        title = Json["title"].string
        summary = Json["summary"].string
        price = Json["price"].string
        category = Json["tags"][0]["title"].string
        pubdate = Json["pubdate"].string
        self.readcount = readcount ?? 0
        self.status = status ?? readStatus.wishList
        self.readdate = readdate ?? Date.init(timeIntervalSince1970: TimeInterval.init(0))
        self.wishdate = wishdate ?? Date.init(timeIntervalSince1970: TimeInterval.init(0))
        self.buydate = buydate ??  Date.init(timeIntervalSince1970: TimeInterval.init(0))
    }
    
    
    func insert()->Void {
        let managedObjectContext = appDelegate.managedContext
        let entity = NSEntityDescription.entity(forEntityName: "Book", in: managedObjectContext)
        let book = NSManagedObject.init(entity: entity!, insertInto: managedObjectContext)
        book.setValue(self.author, forKey: "author")
        book.setValue(self.category, forKey: "category")
        book.setValue(self.image, forKey: "image")
        book.setValue(self.isbn13, forKey: "isbn13")
        book.setValue(self.pages, forKey: "pages")
        book.setValue(self.price, forKey: "price")
        book.setValue(self.pubdate, forKey: "pubdate")
        book.setValue(self.translator, forKey: "translator")
        book.setValue(self.title, forKey: "title")
        book.setValue(self.summary, forKey: "summary")
        book.setValue(self.readcount, forKey: "readcount")
        book.setValue(self.readdate, forKey: "readdate")
        book.setValue(self.status?.rawValue, forKey: "status")
        book.setValue(self.publisher, forKey: "publisher")
        book.setValue(self.wishdate, forKey: "wishdate")
        book.setValue(self.buydate, forKey: "buydate")
        do {
            try managedObjectContext.save()
            print("Insert successfully")
        } catch  {
            fatalError("无法保存")
        }
    }
    
}
