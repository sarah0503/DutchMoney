//
//  GroupMainVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/25.
//

import UIKit
import FirebaseFirestore
import Firebase
import SQLite3

var GNames = [String]()
var GMoneys = [Int32]()
var db : OpaquePointer?


//let items = Firestore.firestore()

class GroupMainVC: UIViewController {
   
    @IBOutlet var tvListView: UITableView!
    
    
    override func viewDidLoad() {
        tvListView.delegate = self
        tvListView.dataSource = self
        super.viewDidLoad()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
            
        let myDB = FMDatabase(path: databasePath as String)
        if myDB.open(){
            let sql_stmt = "CREATE TABLE IF NOT EXISTS group_info ( g_name TEXT NOT NULL, g_money INTEGER NOT NULL, group_count INTEGER, PRIMARY KEY(g_name)) "
            if !myDB.executeStatements(sql_stmt){
                
            }
        }
            if myDB == nil{
            print("Error: \(myDB.lastErrorMessage())")
        }
            
            if myDB.open(){
                let sql = "SELECT * FROM group_info;"
                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
                
                if(result == nil){
                    print("Error: \(myDB.lastErrorMessage())")
                }else{
                    var gName = ""
                    var gMoney : Int32
                    GNames.removeAll()
                    GMoneys.removeAll()
                    
                    while(result?.next() == true){
                        gName = (result?.string(forColumn: "g_name"))!
                        gMoney = (result?.int(forColumn: "g_money"))!
                        
                        GNames.append(gName)
                        GMoneys.append(gMoney)
                    }
                }
            }else{
                print("Error: \(myDB.lastErrorMessage())")
            }
        tvListView.reloadData()
        //}
    }
    
    
    override func viewWillAppear(_ animated: Bool) {let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        //if filemgr.fileExists(atPath: databasePath) == false{
            
        let myDB = FMDatabase(path: databasePath as String)
        if myDB.open(){
            let sql = "SELECT * FROM group_info;"
            let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
            
            if(result == nil){
                print("Error: \(myDB.lastErrorMessage())")
            }else{
                var gName = ""
                var gMoney : Int32
                GNames.removeAll()
                GMoneys.removeAll()
                
                while(result?.next() == true){
                    gName = (result?.string(forColumn: "g_name"))!
                    gMoney = (result?.int(forColumn: "g_money"))!
                    
                    GNames.append(gName)
                    GMoneys.append(gMoney)
                }
            }
        }else{
            print("Error: \(myDB.lastErrorMessage())")
        }
        
        tvListView.reloadData()
    }

}

extension GroupMainVC : UITableViewDelegate, UITableViewDataSource{

    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return GNames.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let groupcell = tableView.dequeueReusableCell(withIdentifier : "groupCell", for : indexPath) as! GroupCellTableViewCell
    
        groupcell.textLabel?.text = GNames[indexPath.row]
        groupcell.groupMoneyLabel.text = NSString(format:"%d",GMoneys[indexPath.row]) as String
        return groupcell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            //GNames.remove(at: indexPath.row) 
            
            //sql 삭제 쿼리
            let filemgr = FileManager.default
            let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
            
            let myDB = FMDatabase (path:databasePath)
            
            if myDB.open(){
                //그룹 지우기
                let delete_gSQL = "DELETE FROM group_info WHERE g_name = '\(GNames[indexPath.row])'"
                let result1 = myDB.executeUpdate(delete_gSQL, withArgumentsIn: [])
                //사람 지우기
                let delete_pSQL = "DELETE FROM person_info WHEREg_name = '\(GNames[indexPath.row])'"
                let result2 = myDB.executeUpdate(delete_pSQL, withArgumentsIn: [])
                //내역 지우기
                let delete_mSQL = "DELETE FROM momey_list WHEREg_name = '\(GNames[indexPath.row])'"
                let result3 = myDB.executeUpdate(delete_mSQL, withArgumentsIn: [])
            }
            
            if myDB.open(){
                let sql = "SELECT * FROM group_info;"
                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
                
                if(result == nil){
                    print("Error: \(myDB.lastErrorMessage())")
                }else{
                    var gName = ""
                    var gMoney : Int32
                    GNames.removeAll()
                    GMoneys.removeAll()
                    
                    while(result?.next() == true){
                        gName = (result?.string(forColumn: "g_name"))!
                        gMoney = (result?.int(forColumn: "g_money"))!
                        
                        GNames.append(gName)
                        GMoneys.append(gMoney)
                    }
                }
            }else{
                print("Error: \(myDB.lastErrorMessage())")
            }
            
            tvListView.reloadData()
            
            
        } else if editingStyle == .insert{
            
        }
    }

//    override func prepareForSegue(segue : UIStoryboardSegue, sender : AnyObject?){
//    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PersonSegue"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tvListView.indexPath(for: cell)
            let nav = segue.destination as! UINavigationController
            let detailView = nav.topViewController as! GroupDetailVC
            detailView.receiveGruop(group: GNames[(indexPath?.row)!])
            tvListView.reloadData()
        }
    }
    
    /*****************************************/
    func reloadTable(){
        super.viewDidLoad()
    }
    
    class reloadtable{
        func GroupReloadTable(){
            
            let VC = GroupMainVC()
            VC.tvListView.reloadData()
        }
        
    }
    /*****************************************/
    
//    private func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
//        let cell = tableView.dequeueReusableCell( withIdentifier: "myCell", for : indexPath as IndexPath)
//        cell.textLabel?.text = items[indexPath.row]
//    }
    

    
    
}
