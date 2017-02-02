//
//  LoginViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//
// This is the first view that is shown to the user. The user could log-in or register if there is no admin user registered in the database.


import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    

    // MARK: - Override functions
    override func viewDidLoad() {
        super.viewDidLoad()
        checkAdmin()
        autoLogin()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide keyboard when user touches outside keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - functions
    // Check if a admin user exists in FireBase.
    func checkAdmin() {
        self.registerButton.isHidden = true
        User.admin = 0
        
        let ref = FIRDatabase.database().reference().child("users")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            let dict = snapshot.value as? NSDictionary
            if dict == nil {
                self.registerButton.isHidden = false
                User.admin = 2
            }
        })
    }
    
    // Login the user automatic when it was already logged in.
    func autoLogin() {
        
    if let uid = FIRAuth.auth()?.currentUser?.uid {
        let ref = FIRDatabase.database().reference().child("users")
        
        ref.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.hasChildren() {
                UserDefaults.standard.removeObject(forKey: "userData")
                UserDefaults.standard.synchronize()
                
                // Get user value and save it in userDefaults
                let dict = snapshot.value as? NSDictionary
                UserDefaults.standard.set(dict, forKey: "userData")
                UserDefaults.standard.synchronize()
                }
            })
        }
    }
    
    // Hide keyboard when user touches return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // Alert function to make an alert.
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Terug", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Actions funtions
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) {
                                (user, error) in
                                if error != nil {
                                    self.alert(title: "Foutmelding met inloggen.", message: "Type een geldig email en wachtwoord.")
                                }
                                self.autoLogin()
                                self.performSegue(withIdentifier: "toHomeView", sender: self)
        }
    }
    
    @IBAction func registerDidTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "toRegisterView", sender: self)
    }
}
