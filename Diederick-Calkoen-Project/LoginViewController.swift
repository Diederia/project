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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        
        FIRAuth.auth()!.addStateDidChangeListener() { auth, user in
            if user != nil {
                
                let ref = FIRDatabase.database().reference().child("users").child(User.FirebaseID!)
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    
                    // Get user value
                    let dict = snapshot.value as? NSDictionary
                    UserDefaults.standard.set(dict, forKey: "userData")
                    print(UserDefaults.standard.value(forKey: "userData"))
                })
                self.performSegue(withIdentifier: "toHomeView", sender: self)

            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
