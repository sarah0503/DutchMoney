//
//  PersonAddVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/02/13.
//

import UIKit
import SQLite3

class PersonAddVC: UIViewController {

    @IBOutlet var tfAddItem: UITextField!
    //var receiveGroup = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnAddButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        let myDB = FMDatabase (path:databasePath)
        
        if myDB.open(){
            let insertSQL = "INSERT INTO person_info VALUES ('\(tfAddItem.text!)', 0, '\(receiveGroup)');"
            let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
        }else{
        }
    }
    
    
    
//    func receiveGruop(group : String){
//        receiveGroup = group
//        
//    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
