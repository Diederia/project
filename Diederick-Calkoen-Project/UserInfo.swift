//
//  UserInfo.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import Foundation
import Firebase


struct userInfo {
    
    // MARK: User info
    static var FirebaseEmail = FIRAuth.auth()?.currentUser?.email
    static var FirebaseID = FIRAuth.auth()?.currentUser?.uid
    
    static var id = String()
    static var firstName = String()
    static var surename = String()
    static var mobileNumber = String()
    static var image = String()
}
