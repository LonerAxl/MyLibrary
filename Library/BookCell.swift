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
import Alamofire
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
        Alamofire.request(((row as! BookRow).book?.image)!, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).response{response in
            self.bookImage.image = UIImage.init(data: response.data!)
            self.row.updateCell()
            //error
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
