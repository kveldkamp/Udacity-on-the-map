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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        enableUI(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.subscribeToKeyboardNotifications()
        self.usernameTextfield.delegate = self
        self.passwordTextField.delegate = self
        enableUI(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }

    
    
    @IBAction func loginButtonPressed(_ sender: Any) {
        enableUI(false)
        if usernameTextfield.text == "" || passwordTextField.text == ""{
            displayAlert(title: "Login Failed", message: "Please fill out both fields")
            enableUI(true)
            return
        }
        
        if let username = usernameTextfield.text, let password = passwordTextField.text{
            NetworkingManager.postASession(username: username, password: password, completion: handleLoginResponse(success:error:))
        }
        
        
    }
    
    
    func handleLoginResponse(success: Bool, error: Error?){
        if success{
            performSegue(withIdentifier: "showMap", sender: self)
        }
        else{
            displayAlert(title: "Login Failed", message: "Please Try again with different username / password")
            enableUI(true)
        }
    }
    
    
    func enableUI(_ enable: Bool){
        DispatchQueue.main.async {
            if enable{
                self.activityIndicator.stopAnimating()
            }
            else{
                self.activityIndicator.startAnimating()
            }
            self.activityIndicator.isHidden = enable
            self.loginButton.isEnabled = enable
            self.loginButton.isHidden = !enable
        }
    }
    
    
    //MARK: TextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    

    

}

