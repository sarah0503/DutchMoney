//
//  GroupMainVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/25.
//

import UIKit
import FirebaseFirestore
import Firebase
//var GNames = ["도라에몽", "짱구"]
//var GNames : String = ""
//var GMoneys : Int = -1


//let items = Firestore.firestore()

class GroupMainVC: UIViewController {
   
    @IBOutlet var tvListView: UITableView!
    
    
    override func viewDidLoad() {
        tvListView.delegate = self
        tvListView.dataSource = self
        super.viewDidLoad()
        
        func getData(of userIndex:Int){
            var GNames : String
            var GMoneys : Int
            let ref :  DatabaseReference! = Database.database().reference()
            ref.child("group").child(String(userIndex)).observeSingleEvent(of: .value, with : {
                snapshot in
                let value = snapshot.value as? NSDictionary
                GNames = value?["GName"] as? String ?? "No string"
                GMoneys = value?["GMoney"] as?Int ?? -1
            })
        }
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
        cell.textLabel?.text = GNames[indexPath.row]
//        cell.GroupLabelName.text = items[indexPath.row]

        // Configure the cell...

        return cell
    }
    
    internal func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            GNames.remove(at: indexPath.row)
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
