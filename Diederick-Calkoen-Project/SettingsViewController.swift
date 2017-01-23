//
//  SettingsViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 20/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController {
    
    // MARK - outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var surenameLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var userData = [String:AnyObject]()
    var ref = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        
        firstNameLabel.text = userData["firstName"] as! String?
        surenameLabel.text = userData["surename"] as! String?
        emailLabel.text = userData["email"] as! String?
        mobileTextField.text = userData["mobile"] as! String?
        idLabel.text = userData["id"] as! String?
        
        if userData["userStatus"] as! Int? == 0 {
            userLabel.text = "Leerling"
        } else if userData["userStatus"] as! Int? == 1 {
            userLabel.text = "Docent"
        } else if userData["userStatus"] as! Int? == 2 {
            userLabel.text = "Admin"
        } else {
            userLabel.text = "Onbekend"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Alert function
    func alert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func updateMobileButton(_ sender: Any) {
        let uid = User.FirebaseID
        ref = self.ref.child("users").child(uid!)
        ref.updateChildValues(["mobile": mobileTextField.text!])
        // MISSCHIEN NOG ERROR HANDELING HIER
        self.alert(title: "Gereed" , message: "Het nummer is aangepast.", actionTitle: "Terug")

    }

    @IBAction func updatePasswordButton(_ sender: Any) {

        // Check input
        guard newPasswordTextField.text! != "" && confirmPasswordTextField.text! != "" else {
            self.alert(title: "Error to register", message: "Enter a valid email, password and confrim password.\n Your password needs to be at least 6 character long.", actionTitle: "Dismiss")
            return
        }
        
        guard newPasswordTextField.text!.characters.count >= 6 else {
            self.alert(title: "Error to register", message: "Your password needs to be at least 6 character long.", actionTitle: "Dismiss")
            return
        }
        
        guard newPasswordTextField.text! == confirmPasswordTextField.text! else {
            self.alert(title: "Error to register", message: "The passwords do not match", actionTitle: "Dismiss")
            return
        }
        
        let firUser = FIRAuth.auth()?.currentUser
        let newPassword = newPasswordTextField.text!
        let email = User.FirebaseEmail
        let password = oldPasswordTextField.text!
        
        let credential = FIREmailPasswordAuthProvider.credential(withEmail: email!, password: password)
        
        firUser?.reauthenticate(with: credential) { error in
            if error != nil {
                self.alert(title: "Error" , message: "Het wachtwoord kan niet aangepast worden.", actionTitle: "Terug")
            } else {
                firUser?.updatePassword(newPassword) { error in
                    if error != nil {
                        self.alert(title: "Error" , message: "Het wachtwoord kan niet aangepast worden.", actionTitle: "Terug")
                    } else {
                        self.alert(title: "Gereed" , message: "Het wachtwoord is aangepast.", actionTitle: "Terug")
                    }
                }
            }
        }
    }
}



