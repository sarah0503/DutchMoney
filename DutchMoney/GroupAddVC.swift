//
//  GroupAddVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/25.
//

import UIKit
import SQLite3

class GroupAddVC: UIViewController {

    @IBOutlet var tfAddItem: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddItem(_ sender: UIButton) {
//        GNames.append(tfAddItem.text!)
      //  tfAddItem.text = ""
        self.navigationController?.popViewController(animated: true)
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        let myDB = FMDatabase (path:databasePath)
        
        if myDB.open(){
            let insertSQL = "INSERT INTO group_info VALUES ('\(tfAddItem.text!)', 0,0);"
            let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
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
