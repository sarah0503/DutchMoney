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
        let databasePath = dirPaths.appendingPathComponent("/Users/yoonsarah/DutchMoney.sqlite").path
        
        if !filemgr.fileExists(atPath: databasePath){
            print("DB없음")
        }
        else{
            let myDB = FMDatabase(path: databasePath as String)            if myDB == nil{
                print("Error: \(myDB.lastErrorMessage())")
            }
            if myDB.open(){
                let sql = "SELECT * FROM Group"
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
            GNames.remove(at: indexPath.row) //살려야됨
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            
        } else if editingStyle == .insert{
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tvListView.reloadData()
    }
    
    
    
    
    
//    private func tableView(tableView : UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell{
//        //let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell")
//        let cell = tableView.dequeueReusableCell( withIdentifier: "myCell", for : indexPath as IndexPath)
//        cell.textLabel?.text = items[indexPath.row]
//    }
    

    
    
}
