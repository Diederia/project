//
//  UserInfo.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//
// In this model the user information is represented, not only for in XCode but also to send the user object to FireBase.

import Foundation
import Firebase

struct User {

    // MARK: - Static variables, constants and variables
    static var FirebaseEmail = FIRAuth.auth()?.currentUser?.email
    static var FirebaseID = FIRAuth.auth()?.currentUser?.uid
    static var admin = Int()

    let email: String
    let uid: String
    let key: String
    let ref: FIRDatabaseReference?
    
    var id: String?
    var userStatus: Int?
    var firstName: String?
    var surename: String?
    var mobile: String?
    
    // MARK: - Init and Functions
    // Init authentication data.
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
        key = ""
        ref = nil
    }
    
    // Init user data.
    init (uid: String, email: String, id: String, userStatus: Int, firstName: String, surename: String, mobile: String) {
        self.uid = uid
        self.email = email
        self.id = id
        self.userStatus = userStatus
        self.firstName = firstName
        self.surename = surename
        self.mobile = mobile
        self.key = ""
        self.ref = nil
    }
    
    // Function to send data to FireBase.
    func toAnyObject() -> Any {
        return [ "uid": uid,
                 "email": email,
                 "id": id ?? "geen id",
                 "userStatus": userStatus ?? 0,
                 "firstName": firstName ?? "voornaam onbekend",
                 "surename": surename ?? "achternaam onbekend",
                 "mobile": mobile ?? "mobielnummer onbekend" ]
    }
    
    // Init snapshot to retrieve data from FireBase.
    init(snapshot: FIRDataSnapshot) {
        self.key = snapshot.key
        self.ref = snapshot.ref
        
        let snapValue = snapshot.value as! [String: AnyObject]
        
        self.uid = snapValue["uid"] as! String
        self.email = snapValue["email"] as! String
        self.id = snapValue["id"] as? String
        self.userStatus = snapValue["userStatus"] as? Int
        self.firstName = snapValue["firstName"] as? String
        self.surename = snapValue["surename"] as? String
        self.mobile = snapValue["mobile"] as? String
    }
}
