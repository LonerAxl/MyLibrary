//
//  BookListViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/4.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import CoreData
import Eureka

class BookListViewController: FormViewController {
    var status:readStatus?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section(self.title ?? "" + "列表"){
            $0.tag = "List"
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let section = self.form.sectionBy(tag: "List")
        let managedObjectContext = self.appDelegate.managedContext
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Book")
        fetch.predicate = NSPredicate.init(format: "status == %@", (status?.rawValue)!)
        do{
            let fetchResult = try managedObjectContext.fetch(fetch)
            
            for i in fetchResult{
                let book = i as! Book
                section! <<< BookRow(book.isbn13){
                    $0.book = book
                }
            }
        }catch{
            fatalError("???")
        }
        
        
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
