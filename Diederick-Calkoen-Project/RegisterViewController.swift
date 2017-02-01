//
//  RegisterViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit
import Firebase

class RegsiterViewController: UIViewController, UITextFieldDelegate {
    
    // MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView!
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
    
    override func encodeRestorableState(with coder: NSCoder) {
        coder.encode(emailTextField.text, forKey: "email")
        coder.encode(firstNameTextField.text, forKey: "firstName")
        coder.encode(surenameTextField.text, forKey: "surename")
        coder.encode(idTextField.text, forKey: "id")
        
        coder.encode(mobileTextField.text, forKey: "mobile")
        super.encodeRestorableState(with: coder)
    }
    
    override func decodeRestorableState(with coder: NSCoder) {
        emailTextField.text = coder.decodeObject(forKey: "email") as! String?
        firstNameTextField.text = coder.decodeObject(forKey: "firstName") as! String?
        surenameTextField.text = coder.decodeObject(forKey: "surename") as! String?
        idTextField.text = coder.decodeObject(forKey: "id") as! String?
        mobileTextField.text = coder.decodeObject(forKey: "mobile") as! String?

        super.decodeRestorableState(with: coder)
    }
    
    // MARK: - Hide keyboard when user touches return.
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == firstNameTextField  || textField == surenameTextField  || textField == idTextField || textField == mobileTextField {
            scrollView.setContentOffset(CGPoint(x:0, y:185), animated: true)
        } else {
            scrollView.setContentOffset(CGPoint(x:0, y:75), animated: true)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
        textField.resignFirstResponder()

    }
    
    // MARK: - Functions
    // MARK: Alert function.
    func alert(title: String, message: String, actionTitle: String) {
        let alertController = UIAlertController(title: title , message: message, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Check the provided input for the new user.
    func checkInput() {
        guard emailTextField.text! != "" && passwordTextField.text! != "" && confirmTextField.text! != "" else {
            self.alert(title: "Fountmelding met registreren", message: "Type een geldig emailadres, wachtwoord en bevestigings wachtwoord.\n Het wachtwoord moet minimaal 6 karakters lang zijn.", actionTitle: "Terug")
            return
        }
        
        guard passwordTextField.text!.characters.count >= 6 else {
            self.alert(title: "Fountmelding met registreren", message: "Het wachtwoord moet minimaal 6 karakters lang zijn.", actionTitle: "Terug")
            return
        }
        
        guard passwordTextField.text! == confirmTextField.text! else {
            self.alert(title: "Fountmelding met registreren", message: "De wachtwoorden komen niet overeen.", actionTitle: "Terug")
            return
        }
    }
    
    // MARK: Save User in FireBase.
    func saveUser(userStatus: Int) {
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
            self.alert(title: "Registratie compleet", message: "De gebruiker is nu geregistreerd", actionTitle: "Terug")
            self.clearInputFields()
        }
    }
    
    // MARK: Clear als texfield of the view.
    func clearInputFields() {
        self.emailTextField.text = ""
        self.idTextField.text = ""
        self.userControl.selectedSegmentIndex = 0
        self.firstNameTextField.text = ""
        self.surenameTextField.text = ""
        self.mobileTextField.text = ""
        self.passwordTextField.text = ""
        self.confirmTextField.text = ""
    }
    
    // MARK: - Actions
    @IBAction func registerDidTOuch(_ sender: Any) {
        
        var userStatus = Int()
        checkInput()
        
        if User.admin == 2{
            userStatus = 2
            saveUser(userStatus: userStatus)
            self.performSegue(withIdentifier: "registerToLogin", sender: self)
        } else {
            userStatus = self.userControl.selectedSegmentIndex
            saveUser(userStatus: userStatus)
        }
    }
}
