//
//  GroupDetailVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/25.
//

import UIKit
import SQLite3

var PNames = [String]()
var PMoneys = [Int32]()
var receiveGroup = ""
//var db : OpaquePointer?

class GroupDetailVC: UIViewController {

    
    @IBOutlet var personTvListView: UITableView!
    @IBOutlet var groupLabel: UILabel!
    override func viewDidLoad() {
        
        personTvListView.delegate = self
        personTvListView.dataSource = self
        super.viewDidLoad()
        
        groupLabel.text = receiveGroup
        // Do any additional setup after loading the view.
        
        //Person DB 연결
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
            
        let myDB = FMDatabase(path: databasePath as String)
        if myDB.open(){
            let sql_stmt = "CREATE TABLE IF NOT EXISTS person_info ( p_name TEXT NOT NULL, p_money INTEGER DEFAULT 0, g_name TEXT, PRIMARY KEY(p_name,g_name), FOREIGN KEY(g_name) REFERENCES group_info(g_name) ) "
            if !myDB.executeStatements(sql_stmt){
            }
        }
            if myDB == nil{
            print("Error: \(myDB.lastErrorMessage())")
        }
            
            if myDB.open(){
                PNames.removeAll()
                PMoneys.removeAll()
                let sql = "SELECT * FROM person_info WHERE g_name = '\(receiveGroup)';"
                print(receiveGroup)
                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
                
                if(result == nil){
                    print("Error: \(myDB.lastErrorMessage())")
                }else{
                    var pName = ""
                    var pMoney : Int32
                    PNames.removeAll()
                    PMoneys.removeAll()
                    
                    while(result?.next() == true){
                        pName = (result?.string(forColumn: "p_name"))!
                        pMoney = (result?.int(forColumn: "p_money"))!
                        
                        PNames.append(pName)
                        PMoneys.append(pMoney)
                    }
                }
            }else{
                print("Error: \(myDB.lastErrorMessage())")
            }
        
        personTvListView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        //if filemgr.fileExists(atPath: databasePath) == false{
            
        let myDB = FMDatabase(path: databasePath as String)
        if myDB.open(){
            PNames.removeAll()
            PMoneys.removeAll()
            let sql = "SELECT * FROM person_info WHERE g_name = '\(receiveGroup)';"
            let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
            
            if(result == nil){
                print("Error: \(myDB.lastErrorMessage())")
            }else{
                var pName = ""
                var pMoney : Int32
                PNames.removeAll()
                PMoneys.removeAll()
                
                while(result?.next() == true){
                    pName = (result?.string(forColumn: "p_name"))!
                    pMoney = (result?.int(forColumn: "p_money"))!
                    
                    PNames.append(pName)
                    PMoneys.append(pMoney)
                }
            }
        }else{
            print("Error: \(myDB.lastErrorMessage())")
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PersonAddSegue"{
//            //let cell = sender as! UITableViewCell
//            //let indexPath = self.tvListView.indexPath(for: cell)
//            let addView = segue.destination as! PersonAddVC
//            addView.receiveGruop(group: receiveGroup)
//           
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receiveGruop(group : String){
        receiveGroup = group
        
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



extension GroupDetailVC : UITableViewDelegate, UITableViewDataSource{

    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PNames.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
//        cell.textLabel?.text = PNames[indexPath.row]
        let personcell = tableView.dequeueReusableCell(withIdentifier: "personCell", for : indexPath) as! PersonTableViewCell
        
        personcell.textLabel?.text = PNames[indexPath.row]
        personcell.personMoneyLabel.text = NSString(format:"%d",PMoneys[indexPath.row]) as String
        
//        cell.GroupLabelName.text = items[indexPath.row]

        // Configure the cell...

        return personcell
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
                let insertSQL = "DELETE FROM person_info WHERE p_name = '\(PNames[indexPath.row])'"
                let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
                //tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            if myDB.open(){
                PNames.removeAll()
                PMoneys.removeAll()
                let sql = "SELECT * FROM person_info  WHERE g_name = '\(receiveGroup)';"
                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
                
                if(result == nil){
                    print("Error: \(myDB.lastErrorMessage())")
                }else{
                    var pName = ""
                    var pMoney : Int32
                    PNames.removeAll()
                    PMoneys.removeAll()
                    
                    while(result?.next() == true){
                        pName = (result?.string(forColumn: "p_name"))!
                        pMoney = (result?.int(forColumn: "p_money"))!
                        
                        PNames.append(pName)
                        PMoneys.append(pMoney)
                    }
                }
            }else{
                print("Error: \(myDB.lastErrorMessage())")
            }
            
            personTvListView.reloadData()
            
            
        } else if editingStyle == .insert{
            
        }
    }

//    override func prepareForSegue(segue : UIStoryboardSegue, sender : AnyObject?){
//    }

    
    /***상세정보 일단 보류***/
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PersonSegue"{
//            let cell = sender as! UITableViewCell
//            let indexPath = self.tvListView.indexPath(for: cell)
//            let nav = segue.destination as! UINavigationController
//            let detailView = nav.topViewController as! GroupDetailVC
//            detailView.receiveGruop(group: GNames[(indexPath?.row)!])
//
//        }
//    }
    
    
    
    
    
    
//    private func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
//        let cell = tableView.dequeueReusableCell( withIdentifier: "myCell", for : indexPath as IndexPath)
//        cell.textLabel?.text = items[indexPath.row]
//    }
    

    
    
}
