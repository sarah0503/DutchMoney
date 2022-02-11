//
//  GroupDetailVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/25.
//

import UIKit

class GroupDetailVC: UIViewController {

    
    
    @IBOutlet var groupLabel: UILabel!
    var receiveGroup = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        groupLabel.text = receiveGroup
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func receiveGruop(group : String){
        receiveGroup = group    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
