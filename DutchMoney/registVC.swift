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
        print("HI")

        // Do any additional setup after loading the view.
    }
    
    @IBAction func temp(_ sender: UIButton) {
        print("wow")
    }
    
    @IBAction func doneButtonTouched(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!){
            (user,error) in
            if user != nil{
                let sucessAlert = UIAlertController( title : "확인", message : "회원가입이 완료되었습니다 ", preferredStyle : UIAlertController.Style.alert)
                let onAction = UIAlertAction(title : "확인" ,style: UIAlertAction.Style.default, handler: nil)
                print("register success")
            }
            else{
                print("register fail")
            }
        }
    }
    
//    @IBAction func doneButtonTouched(_ sender: UIButton) {
//        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!){
//            (user,error) in
//            if user != nil{
//                print("register success")
//            }
//            else{
//                print("register fail")
//            }
//        }
//    }
//    
//    
//    @IBAction func temp(_ sender: UIButton) {
//        print("click")
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
