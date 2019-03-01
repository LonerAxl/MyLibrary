//
//  MainViewController.swift
//  Library
//
//  Created by Axl Zhan on 2019/3/1.
//  Copyright © 2019 Axl Zhan. All rights reserved.
//

import UIKit
import Eureka

class MainViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        form +++ Section(){
            $0.tag = "Control"
        }
            <<< ButtonRow("Insert"){
                $0.title = "Insert"
        }.onCellSelection({cell, row in
            
        })
            <<< ButtonRow("Deleter"){
                $0.title = "Delete"
        }.onCellSelection({cell,row in
            
        })
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

}
