//
//  MainViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/1.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import Eureka
import Alamofire
import CoreData
class MainViewController: FormViewController {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section(){
            $0.tag = "Control"
        }
            <<< TextRow("isbn"){
                $0.title = "isbn"
            }
            <<< ButtonRow("Insert"){
                $0.title = "Insert"
        }.onCellSelection({cell, row in
            let text = self.form.rowBy(tag: "isbn") as! TextRow
            if text.value != nil{
                Alamofire.request(self.appDelegate.url + text.value!, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).response{response in
                    let data = response.data
                    var book = BookHelper.init(data: data!, readdate: nil, status: nil, readcount: nil)
                    book.insert()
                }
            }
        })
            <<< ButtonRow("Delete"){
                $0.title = "Delete"
        }.onCellSelection({cell,row in
            
        })
            <<< ButtonRow("Refresh"){
                $0.title = "Refresh"
        }.onCellSelection({cell, row in
            self.reload()
        })
        form +++ Section("列表"){
            $0.tag = "list"
        }
        self.reload()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    func reload(){
        let section = self.form.sectionBy(tag: "list")
        section?.removeAll()
        let managedObjectContext = self.appDelegate.managedContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        do{
            let fetchResult = try managedObjectContext.fetch(fetch)
            
            for i in fetchResult{
                let book = i as! Book
                section! <<< LabelRow(book.isbn13){
                    $0.title = book.title
                    $0.value = book.author
                }
            }
        }catch{
            fatalError("???")
        }
    }
}
