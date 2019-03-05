//
//  BookViewCell.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/4.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import Eureka
import CoreData

class BookCell: Cell<String>, CellType {
    
    @IBOutlet weak var bookImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var publisherLabel: UILabel!
    
    
    public override func setup() {
        super.setup()
        
        height = { return 100}
    }
    
    
    public override func update() {
        super.update()
        textLabel?.text = nil
        detailTextLabel?.text = nil
        titleLabel.text = (row as! BookRow).book?.title
        authorLabel.text = (row as! BookRow).book?.author
        publisherLabel.text = (row as! BookRow).book?.publisher
        do {
            try imageView?.image = UIImage.init(data: Data.init(contentsOf: URL.init(string: ((row as! BookRow).book?.image)!)!))
        }catch{
            print("image Error")
        }

    }
    
    
}


public final class BookRow: Row<BookCell>, RowType {
    var book : Book?
    
    required public init(tag: String?) {
        super.init(tag: tag)
        // 我们把对应CustomCell的 .xib 加载到cellProvidor
        cellProvider = CellProvider<BookCell>(nibName: "BookCell")
    }
}
