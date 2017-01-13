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
    static var userEmail = FIRAuth.auth()?.currentUser?.email
    static var userID = FIRAuth.auth()?.currentUser?.uid
}
