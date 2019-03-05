//
//  ScanResultViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/5.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import SwiftyJSON
class ScanResultViewController: FormViewController {
    var isbn:String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        form +++ Section(){
            $0.tag = "Info"
        }
        <<< LabelRow("Title"){
            $0.title = "书名"
        }
            <<< LabelRow("Author"){
                $0.title = "作者"
        }
            <<< LabelRow("Translator"){
                $0.title = "译者"
            }
            <<< LabelRow("Publisher"){
                $0.title = "出版社"
        }
            <<< LabelRow("ISBN"){
                $0.title = "ISBN"
        }
            <<< TextAreaRow("Summary"){
                $0.value = ""
                $0.textAreaHeight = .fixed(cellHeight: 110)
        }
            <<< LabelRow("Price"){
                $0.title = "价格"
        }
            
            <<< LabelRow("Pages"){
                $0.title = "页数"
        }
            <<< LabelRow("Pubdate"){
                $0.title = "出版日期"
        }
            <<< LabelRow("Category"){
                $0.title = "类型"
            }
            <<< PickerRow<String>("Status"){
                $0.title = "分类放置"
                $0.options = [readStatus.read.rawValue, readStatus.unread.rawValue, readStatus.wishList.rawValue]
        }
        
        if isbn != nil{
            Alamofire.request(self.appDelegate.url + isbn!, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).response{response in
                let data = response.data
                do {
                    let json = try JSON.init(data: data!)
                    print(json.stringValue)
                }catch{
                    print("error")
                }
                
                
                var book = BookHelper.init(data: data!, readdate: nil, status: nil, readcount: nil, wishdate: nil, buydate: nil)
                
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func updateView(book: Book){
        var row = self.form.rowBy(tag: "Title") as! LabelRow
        row.value = book.title
        row.updateCell()
        row = self.form.rowBy(tag: "Author") as! LabelRow
        row.value = book.author
        row.updateCell()
        row = self.form.rowBy(tag: "Translator") as! LabelRow
        row.value = book.translator
        row.updateCell()
        row = self.form.rowBy(tag: "Publisher") as! LabelRow
        row.value = book.publisher
        row.updateCell()
        row = self.form.rowBy(tag: "ISBN") as! LabelRow
        row.value = book.isbn13
        row.updateCell()
        var row2 = self.form.rowBy(tag: "Summary") as! TextAreaRow
        row2.value = book.summary
        row2.textAreaMode = .readOnly
        row2.updateCell()
        row = self.form.rowBy(tag: "Price") as! LabelRow
        row.value = book.price
        row.updateCell()
        row = self.form.rowBy(tag: "Pages") as! LabelRow
        row.value = String(book.pages)
        row.updateCell()
        row = self.form.rowBy(tag: "Pubdate") as! LabelRow
        row.value = book.pubdate
        row.updateCell()
        row = self.form.rowBy(tag: "Category") as! LabelRow
        row.value = book.category
        row.updateCell()
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
