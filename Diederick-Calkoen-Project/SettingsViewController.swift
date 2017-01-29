//
//  SettingsViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 20/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import Firebase

class SettingsViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var settingsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var firstAndSurenameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailAddressLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var idTextField: UITextField!
    @IBOutlet weak var idButton: UIButton!
    @IBOutlet weak var mobileButton: UIButton!
    @IBOutlet weak var mobileLabel: UILabel!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    // MARK: - Variables
    var userData = [String:AnyObject]()
    var ref = FIRDatabase.database().reference()

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.setContentOffset(CGPoint(x:0, y:-64), animated: true)
        
        setupRoundCorners()
        setupText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Hide keyboard when user touches return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == idTextField  || textField == mobileTextField  || textField == oldPasswordTextField || textField == newPasswordTextField || textField == confirmPasswordTextField {
            scrollView.setContentOffset(CGPoint(x:0, y:175), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x:0, y:75), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
    // MARK: - Functions
    func setupText() {
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        
        firstAndSurenameLabel.text = (userData["firstName"] as! String?)! + " " + (userData["surename"] as! String?)!
        emailAddressLabel.text = userData["email"] as! String?
        idTextField.text = userData["id"] as! String?
        mobileTextField.text = userData["mobile"] as! String?
        
        if userData["userStatus"] as! Int? == 0 {
            userLabel.text = "Leerling"
        } else if userData["userStatus"] as! Int? == 1 {
            userLabel.text = "Docent"
        } else if userData["userStatus"] as! Int? == 2 {
            userLabel.text = "Admin"
        }
    }
    
    func setupRoundCorners() {
        settingsLabel.layer.cornerRadius = 5
        settingsLabel.layer.borderWidth = 2
        settingsLabel.layer.borderColor = UIColor.white.cgColor
        
        passwordLabel.layer.cornerRadius = 5
        passwordLabel.layer.borderWidth = 2
        passwordLabel.layer.borderColor = UIColor.white.cgColor

        
        nameLabel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        firstAndSurenameLabel.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        firstAndSurenameLabel.layer.borderWidth = 2
        firstAndSurenameLabel.layer.borderColor = UIColor.white.cgColor
        
        emailLabel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        emailAddressLabel.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        emailAddressLabel.layer.borderWidth = 2
        emailAddressLabel.layer.borderColor = UIColor.white.cgColor
        
        statusLabel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        userLabel.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        userLabel.layer.borderWidth = 2
        userLabel.layer.borderColor = UIColor.white.cgColor
        
        idLabel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        idButton.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
        mobileLabel.roundCorners(corners: [.topLeft, .bottomLeft], radius: 5)
        mobileButton.roundCorners(corners: [.topRight, .bottomRight], radius: 5)
    }
    
    func alert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: actionTitle, style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    func checkInput() {
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
    }
    
    // MARK: - Actions
    @IBAction func updateIdButton(_ sender: Any) {
        let uid = User.FirebaseID
        ref = self.ref.child("users").child(uid!)
        ref.updateChildValues(["id": mobileTextField.text!])
        // MISSCHIEN NOG ERROR HANDELING HIER
        self.alert(title: "Gereed" , message: "Het id is aangepast.", actionTitle: "Terug")
    }
    
    @IBAction func updateMobileButton(_ sender: Any) {
        let uid = User.FirebaseID
        ref = self.ref.child("users").child(uid!)
        ref.updateChildValues(["mobile": mobileTextField.text!])
        // MISSCHIEN NOG ERROR HANDELING HIER
        self.alert(title: "Gereed" , message: "Het nummer is aangepast.", actionTitle: "Terug")

    }

    @IBAction func updatePasswordButton(_ sender: Any) {

        // MARK: - Check input
        checkInput()
        
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


