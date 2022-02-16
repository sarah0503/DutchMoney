//
//  registVC.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/20.
//

import UIKit
import FirebaseAuth
import Firebase

class registVC: UIViewController {

    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HI")

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func doneButtonTouched(_ sender: Any) {
        Auth.auth().createUser(withEmail: emailTextField.text!, password: pwTextField.text!){
            (user,error) in
            if user != nil{
                let sucessAlert = UIAlertController( title : "확인", message : "회원가입이 완료되었습니다 ", preferredStyle : UIAlertController.Style.alert)
                let onAction = UIAlertAction(title : "확인" ,style: UIAlertAction.Style.default, handler: {_ in
                    let newVC = self.storyboard?.instantiateViewController(identifier: "mainBoard")
                    newVC?.modalTransitionStyle  = .coverVertical
                    newVC?.modalPresentationStyle = .automatic
                    self.present(newVC!, animated: true, completion: nil)
                })
                sucessAlert.addAction(onAction)
                self.present(sucessAlert, animated: true, completion: nil)
                print("register success")
            }
            else{
                let failAlert = UIAlertController( title : "확인", message : "회원가입이 정상적으로 처리되지 않았습니다. ", preferredStyle : UIAlertController.Style.alert)
                let onAction = UIAlertAction(title : "확인" ,style: UIAlertAction.Style.default, handler: nil)
                failAlert.addAction(onAction)
                self.present(failAlert, animated: true, completion: nil)
                print("register fail")
                
                //나중에 성공 케이스 나오면 옮기기..
                
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
