//
//  LoginVC.swift
//  onTheMap
//
//  Created by Kevin Veldkamp on 6/10/19.
//  Copyright © 2019 kevin veldkamp. All rights reserved.
//

import UIKit

class LoginVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.usernameTextfield.delegate = self
        self.passwordTextField.delegate = self
        
    }
    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    

}

