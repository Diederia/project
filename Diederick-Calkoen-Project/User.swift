//
//  UserInfo.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import Foundation
import Firebase


struct User {

//    // MARK: User info
    static var FirebaseEmail = FIRAuth.auth()?.currentUser?.email
    static var FirebaseID = FIRAuth.auth()?.currentUser?.uid

    let email: String
    let uid: String
    let key: String
    let ref: FIRDatabaseReference?
    
    var id: String?
    var userStatus: Int?
    var firstName: String?
    var surename: String?
    var mobile: String?
 
    init(authData: FIRUser) {
        uid = authData.uid
        email = authData.email!
        key = ""
        ref = nil
    }
        
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
    
    func toAnyObject() -> Any {
        return [ "uid": uid,
                 "email": email,
                 "id": id ?? "geen id",
                 "userStatus": userStatus ?? 0,
                 "firstName": firstName ?? "voornaam onbekend",
                 "surename": surename ?? "achternaam onbekend",
                 "mobile": mobile ?? "mobielnummer onbekend" ]
    }
}
