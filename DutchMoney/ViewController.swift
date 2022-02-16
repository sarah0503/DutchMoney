//
//  ViewController.swift
//  DutchMoney
//
//  Created by 윤새라 on 2022/01/18.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var autoLogin: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        if let user = Auth.auth().currentUser{
//            emailTextField.placeholder = "이미 로그인 된 상태입니다. "
//            pwTextField.placeholder = "이미 로그인 된 상태입니다. "
//
//        }
        
        
    }


    @IBAction func didTapAutoLogin(_ sender: UIButton) {
        sender.isSelected.toggle()
    }
    
    @IBAction func loginButtonTouched(_ sender: Any) {
        Auth.auth().signIn(withEmail : emailTextField.text!, password : pwTextField.text!){ (user,error) in
            
            if user != nil{
                print("login success")
            }
            else{
                print("login fail")
            }
            
        }
    }
    
    @IBAction func RegisterButtonTouched(_ sender: UIButton) {
        let newVC = self.storyboard?.instantiateViewController(identifier: "registBoard")
        newVC?.modalTransitionStyle  = .coverVertical
        newVC?.modalPresentationStyle = .automatic
        self.present(newVC!, animated: true, completion: nil)
    }
    //    @IBAction func registerButton(segue : UIStoryboardSegue {
//    }
    
}

