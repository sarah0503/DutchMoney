//
//  MoneyAddVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/03/14.
//
import UIKit

class MoneyAddVC: UIViewController {

    @IBOutlet var moneyNameTf: UITextField!
    @IBOutlet var moneyTf: UITextField!
    @IBOutlet var personMoneyTvListView: UITableView!
    
    @IBAction func doneButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        let filemgr = FileManager.default
        let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
        
        let myDB = FMDatabase (path:databasePath)
        
        //DB생성
        if myDB.open(){
            let sql_stmt = "CREATE TABLE IF NOT EXISTS money_list ( m_name TEXT, money INTEGER, g_name  TEXT, FOREIGN KEY(g_name) REFERENCES group_info(g_name)"
            if !myDB.executeStatements(sql_stmt){
            }
        }
        //DB추가
        if myDB.open(){
                  //let insertSQL = "INSERT INTO person_info VALUES ('\(tfAddItem.text!)', 0, '\(receiveGroup)');"
                  //let money:Int? = Int(moneyTf.text!)
                  let money = ( (moneyTf.text!) as NSString).integerValue
                  print(money)
                  let insertSQL = "INSERT INTO money_list VALUES ('\(moneyNameTf.text!)', '\(money)', '\(receiveGroup)')"
                  let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
              //GroupDB에서 금액 가져오기
      //            let moneySQL = "SELECT g_money FROM group_info WHERE g_name = '\(receiveGroup)'"
      //            let moneyResult:FMResultSet? = myDB.executeQuery(moneySQL, withParameterDictionary : nil)
      //            let groupMoney = Int(moneyResult?.int(forColumn: "g_money") ?? <#default value#>)
      //            let updatedMoney = groupMoney + money
      //
      //            print(groupMoney)
                  
              //GroupDB에 금액 수정
                  let groupUpdateSQL = "UPDATE group_info SET g_money = g_money + \(money) WHERE g_name = '\(receiveGroup)'"
                  
                   let groupUpdateResult = myDB.executeUpdate(groupUpdateSQL, withArgumentsIn: [])
              }else{
              }
            
            /*****************************************/
            //let vc = GroupMainVC.reloadtable()
            //vc.GroupReloadTable()
            
    //        NotificationCenter.default.post(name: Notification.Name("reloadGroupTable"), object: nil)
        
        
    }
    override func viewDidLoad() {
        personMoneyTvListView.delegate = self
        personMoneyTvListView.dataSource = self
        super.viewDidLoad()
        
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
        
        personMoneyTvListView.reloadData()

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

extension MoneyAddVC : UITableViewDelegate, UITableViewDataSource{

    
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PNames.count
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                 let moneyaddcell = tableView.dequeueReusableCell(withIdentifier : "moneyAddCell", for : indexPath) as! MoneyAddTableViewCell
         
         moneyaddcell.personMoneyAddLabel
             
            
             
             
             .text = PNames[indexPath.row]
         
                 return moneyaddcell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
//        if editingStyle == .delete{
//            let filemgr = FileManager.default
//            let dirPaths = filemgr.urls(for: .documentDirectory, in: .userDomainMask)[0]
//            let databasePath = dirPaths.appendingPathComponent("DutchMoney.sqlite").path
//
//            let myDB = FMDatabase (path:databasePath)
//
//            if myDB.open(){
//                let insertSQL = "DELETE FROM group_info WHERE g_name = '\(GNames[indexPath.row])'"
//                let result = myDB.executeUpdate(insertSQL, withArgumentsIn: [])
//                //tableView.deleteRows(at: [indexPath], with: .fade)
//            }
//
//            if myDB.open(){
//                let sql = "SELECT * FROM group_info;"
//                let result:FMResultSet? = myDB.executeQuery(sql, withParameterDictionary : nil)
//
//                if(result == nil){
//                    print("Error: \(myDB.lastErrorMessage())")
//                }else{
//                    var gName = ""
//                    var gMoney : Int32
//                    GNames.removeAll()
//                    GMoneys.removeAll()
//
//                    while(result?.next() == true){
//                        gName = (result?.string(forColumn: "g_name"))!
//                        gMoney = (result?.int(forColumn: "g_money"))!
//
//                        GNames.append(gName)
//                        GMoneys.append(gMoney)
//                    }
//                }
//            }else{
//                print("Error: \(myDB.lastErrorMessage())")
//            }
//
//
//
//        } else if editingStyle == .insert{
//
//        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "PersonSegue"{
//            let cell = sender as! UITableViewCell
//            let indexPath = self.tvListView.indexPath(for: cell)
//            let nav = segue.destination as! UINavigationController
//            let detailView = nav.topViewController as! GroupDetailVC
//            detailView.receiveGruop(group: GNames[(indexPath?.row)!])
//
//        }
    }
    
    
    

    
    
}
