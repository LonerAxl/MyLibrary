//
//  MainV2ViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/4.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import Eureka
import Alamofire

class MainV2ViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        form +++ Section(){
            $0.tag = "List"
        }
            <<< ButtonRow("Library"){
                $0.title = "书库"
        }.onCellSelection({cell, row in
            self.performSegue(withIdentifier: "MainSegue", sender: row)
        })
            <<< ButtonRow("Read"){
                $0.title = "已读"
                }.onCellSelection({cell, row in
                    self.performSegue(withIdentifier: "MainSegue", sender: row)
                })
            <<< ButtonRow("Unread"){
                $0.title = "未读"
                }.onCellSelection({cell, row in
                    self.performSegue(withIdentifier: "MainSegue", sender: row)
                })
            <<< ButtonRow("WishList"){
                $0.title = "愿望单"
                }.onCellSelection({cell, row in
                    self.performSegue(withIdentifier: "MainSegue", sender: row)
                })
        // Do any additional setup after loading the view.
    }
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "MainSegue"{
            let destVC = segue.destination as! BookListViewController
            destVC.status = readStatus(rawValue: (sender as! ButtonRow).tag!.lowercased())
            destVC.title = (sender as! ButtonRow).title
        }
    }
 

}
