//
//  LoginViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var textFieldLoginEmail: UITextField!
    @IBOutlet weak var textFieldLoginPassword: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
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
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {

                let userId = FIRAuth.auth()?.currentUser?.uid
                let ref = FIRDatabase.database().reference().child("users").child(userId!)
                
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    // NOG KIJKEN OF DIT NODIG IS
                    UserDefaults.standard.removeObject(forKey: "userData")
                    UserDefaults.standard.synchronize()
                   


                    // Get user value
                    let dict = snapshot.value as? NSDictionary
                    UserDefaults.standard.set(dict, forKey: "userData")
                    UserDefaults.standard.synchronize()
                    


                    self.performSegue(withIdentifier: "toHomeView", sender: self)
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Hide keyboard when user touches outside keyboard.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // MARK: - Hide keyboard when user touches return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: Actions funtions
    @IBAction func loginDidTouch(_ sender: Any) {
        FIRAuth.auth()!.signIn(withEmail: textFieldLoginEmail.text!,
                               password: textFieldLoginPassword.text!) {
                                (user, error) in
                                if error != nil {
                                    self.alert(title: "Error with loggig in", message: "Enter a valid email and password.")
                                }
        }
    }
    @IBAction func registerDidTouch(_ sender: Any) {
        self.performSegue(withIdentifier: "toRegisterView", sender: self)
    }
    
    // MARK: Alert function
    func alert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
