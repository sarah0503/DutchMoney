//
//  registVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/20.
//

import UIKit
import Firebase

class registVC: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func registButtonTouched( sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!){
            (user,error) in
            if user != nil{
                print("register success")
            }
            else{
                print("register fail")
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
