//
//  MoneyListVC.swift
//  DutchMoney/Users/yoonsarah/Documents/GitHub/DutchMoney/DutchMoney/MoneyListVC.swift/Users/yoonsarah/Documents/GitHub/DutchMoney/DutchMoney/GroupMainVC.swift
//
//  Created by 윤새라 on 2022/03/16.
//

import UIKit
var MNames = [String]()
var MMoneys = [Int32]()

class MoneyListVC: UIViewController {

    @IBOutlet var tvMoneyList: UITableView!
    override func viewDidLoad() {
        tvMoneyList.delegate = self
        tvMoneyList.dataSource = self
        super.viewDidLoad()
        
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
            
        let myDB = FMDatabase(path: databasePath as String)
//        if myDB.open(){
//            let sql_stmt = "CREATE TABLE IF NOT EXISTS group_info ( g_name TEXT NOT NULL, g_money INTEGER NOT NULL, PRIMARY KEY(g_name)) "
//            if !myDB.executeStatements(sql_stmt){
//
//            }
//        }
            if myDB == nil{
            print("Error: \(myDB.lastErrorMessage())")
        }
            
            if myDB.open(){
                let sql = "SELECT * FROM money_list WHERE g_name = '\(receiveGroup)';"
                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
                
                if(result == nil){
                    print("Error: \(myDB.lastErrorMessage())")
                }else{
                    var mName = ""
                    var mMoney : Int32
                    MNames.removeAll()
                    MMoneys.removeAll()
                    
                    while(result?.next() == true){
                        mName = (result?.string(forColumn: "m_name"))!
                        mMoney = (result?.int(forColumn: "money"))!
                        
                        MNames.append(mName)
                        MMoneys.append(mMoney)
                        print(mName)
                        print(mMoney)
                    }
                }
            }else{
                print("Error: \(myDB.lastErrorMessage())")
            }
        tvMoneyList.reloadData()
    

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

extension MoneyListVC : UITableViewDelegate, UITableViewDataSource{

    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return MNames.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let moneylistcell = tableView.dequeueReusableCell(withIdentifier: "moneyListCell", for: indexPath) as! MoneyListTableViewCell
         
         //moneylistcell.moneyNameLabel.text =
         moneylistcell.textLabel?.text = MNames[indexPath.row]
         
         moneylistcell.momeyMomeyLabel.text = NSString(format:"%d", MMoneys[indexPath.row]) as String
         return moneylistcell
         
         
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
                let insertSQL = "DELETE FROM moneylist WHERE g_name = '\(GNames[indexPath.row])'"
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

            tvMoneyList.reloadData()

            
 }
    else if editingStyle == .insert{
    }
        }
    }

//    override func prepareForSegue(segue : UIStoryboardSegue, sender : AnyObject?){
//    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PersonSegue"{
//            let cell = sender as! UITableViewCell
//            let indexPath = self.tvListView.indexPath(for: cell)
//            let nav = segue.destination as! UINavigationController
//            let detailView = nav.topViewController as! GroupDetailVC
//            detailView.receiveGruop(group: GNames[(indexPath?.row)!])
//            tvListView.reloadData()
//        }
//    }
    
    /*****************************************/

    /*****************************************/
    
//    private func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
//        let cell = tableView.dequeueReusableCell( withIdentifier: "myCell", for : indexPath as IndexPath)
//        cell.textLabel?.text = items[indexPath.row]
//    }
    

    
    

