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
//var GNames = ["도라에몽", "짱구"]
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
        
//        func getData(of userIndex:Int){
//            //var GNames : String
//            //var GMoneys : Int
//            let ref :  DatabaseReference! = Database.database().reference()
//            ref.child("group").child(String(userIndex)).observeSingleEvent(of: .value, with : {
//                snapshot in
//                let value = snapshot.value as? NSDictionary
//                GNames = value?["GName"] as? String ?? "No string"
//                GMoneys = value?["GMoney"] as?Int ?? -1
//
//                print("고양이")
//            })
//        }
        
        
        // Do any additional setup after loading the view.
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        //if filemgr.fileExists(atPath: databasePath) == false{
            
            let myDB = FMDatabase(path: databasePath as String)
            if myDB.open(){
                let sql_stmt = "CREATE TABLE IF NOT EXISTS group_info ( g_name TEXT NOT NULL, g_money INTEGER NOT NULL, PRIMARY KEY(g_name)) "
                if !myDB.executeStatements(sql_stmt){
                
                }
            }
        //}
       // else{
           // let myDB = FMDatabase(path: databasePath as String)
            print("DB있음")
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        cell.textLabel?.text = GNames[indexPath.row] //살려야됨
        
//        cell.GroupLabelName.text = items[indexPath.row]

        // Configure the cell...

        return cell
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
                let insertSQL = "DELETE FROM group_info WHERE g_name = '\(GNames[indexPath.row])'"
                let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
                //tableView.deleteRows(at: [indexPath], with: .fade)
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
    
    
    
    
    
//    private func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
//        let cell = tableView.dequeueReusableCell( withIdentifier: "myCell", for : indexPath as IndexPath)
//        cell.textLabel?.text = items[indexPath.row]
//    }
    

    
    
}
