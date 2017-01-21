//
//  SettingsViewController.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 20/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit

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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        userData = UserDefaults.standard.value(forKey: "userData") as! [String : AnyObject]
        print(userData)
        
        firstNameLabel.text = userData["fistName"] as! String?
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
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func updateMobileButton(_ sender: Any) {
        
    }

    @IBAction func updatePasswordButton(_ sender: Any) {
        
    }

}
