//
//  RegisterViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import Firebase

class RegsiterViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var surenameTextField: UITextField!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var userControl: UISegmentedControl!
    
    // MARK: - Variables
    var ref = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if User.admin == 2{
            userControl.isHidden = true
        } else {
            userControl.isHidden = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: Register funtion
    @IBAction func registerDidTOuch(_ sender: Any) {
        var userStatus = Int()
        
        // Check input
        guard emailTextField.text! != "" && passwordTextField.text! != "" && confirmTextField.text! != "" else {
            self.alert(title: "Error to register", message: "Enter a valid email, password and confrim password.\n Your password needs to be at least 6 character long.", actionTitle: "Dismiss")
            return
        }
        
        guard passwordTextField.text!.characters.count >= 6 else {
            self.alert(title: "Error to register", message: "Your password needs to be at least 6 character long.", actionTitle: "Dismiss")
            return
        }
        
        guard passwordTextField.text! == confirmTextField.text! else {
            self.alert(title: "Error to register", message: "The passwords do not match", actionTitle: "Dismiss")
            return
        }
        
        if User.admin == 2{
            userStatus = 2
        } else {
        userStatus = self.userControl.selectedSegmentIndex
        }
        
        // Save user in firebase
        FIRAuth.auth()!.createUser(withEmail: self.emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            if error != nil {
                self.alert(title: "Error to register", message: "Error with database", actionTitle: "Dismiss")
                return
            }

            let user = User(uid: (user?.uid)!,
                            email: self.emailTextField.text!,
                            id: self.idTextField.text!,
                            userStatus: userStatus,
                            firstName: self.firstNameTextField.text!,
                            surename: self.surenameTextField.text!,
                            mobile: self.mobileTextField.text!)
            
            let userRef = self.ref.child("users").child((user.uid))
            userRef.setValue(user.toAnyObject())
            
            if User.admin == 2 {
                self.performSegue(withIdentifier: "registerToLogin", sender: self)
            }
            
            // Registering completed
            self.alert(title: "Registratie compleet", message: "De gebruiker is nu geregistreerd", actionTitle: "Terug")

            self.emailTextField.text = ""
            self.idTextField.text = ""
            self.userControl.selectedSegmentIndex = 0
            self.firstNameTextField.text = ""
            self.surenameTextField.text = ""
            self.mobileTextField.text = ""
            self.passwordTextField.text = ""
            self.confirmTextField.text = ""
        }
    }
    
    // MARK: Alert function
    func alert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
}
