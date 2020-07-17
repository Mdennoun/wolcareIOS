//
//  LoginViewController.swift
//  wolcare
//
//  Created by Mohamed dennoun on 07/05/2020.
//  Copyright © 2020 Mohamed dennoun. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var mail: UITextField!
    @IBOutlet var password: UITextField!
    
    
    let loginService: LoginService = LoginService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true);
        self.tabBarController?.tabBar.isHidden = true
        
        
        navigationItem.title = "Wolcare"
        self.mail.delegate = self
        self.mail.tag = 1
        self.password.delegate = self
        self.password.tag = 2
        self.definesPresentationContext = true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
         switch textField {
           case mail:
               password.becomeFirstResponder()
           case password:
                self.view.endEditing(true)
           default:
               textField.resignFirstResponder()
           }
           return false
    }
    
    @IBAction func login(_ sender: Any) {
        
        print("mail: \(String(describing: mail.text)), password: \(String(describing: password.text))")
        let date = Date()



        let user = User(_id: nil, email: mail.text ?? "test1@test.fr", password: password.text ?? "test2", type: "0", pseudo: "String", firstname: "String", lastname: "String", birthdate: date.debugDescription , sex: true, photo: "String", requestIssued: 0, requestFulfilled: 0 )
        
        self.loginService.login(user: user) { (success) in
            
            print("\(success)")
        }

        self.navigationController?.pushViewController(HomeViewController(), animated: true)
        
    }
    @IBAction func Signup(_ sender: Any) {
        self.navigationController?.pushViewController(SignInViewController(), animated: true)
    }
    

}
