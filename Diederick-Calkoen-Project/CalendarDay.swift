//
//  CalendarDay.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 18/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import Foundation
import Firebase

struct CalendarDay {
    
//    var dataRef: FIRDatabaseReference!
    

    // MARK: Calendar day info
    static var calendarDayDate = String()
    static var dataOfDate = [(String): String]()
    static var sectionId = Int()
    static var dataOfSection = [String: String]()

}
//    var ref = FIRDatabase.database().reference()

//    
//    
////    let key: String
////    let ref: FIRDatabaseReference?
//    
//    var date: String
//    var startTime: String
//    var endTime: String
//    var teacherId: String
//    var studentId: String
//    
//    
//    init (datum: String, startTime: String, endTime: String, teacherId: String, studentId: String) {
//        self.date = datum
//        self.startTime = startTime
//        self.endTime = endTime
//        self.teacherId = teacherId
//        self.studentId = studentId
//    }

//    func toAnyObject() -> Any {
//        return [ self.ref.child("data").child(calendarDayDate).child(sectionId).setValue(["teacheId":teacherId, "time": self.dataOfSection]),
//            
//            "date": date,
//            "startTime": startTime,
//            "endTime": endTime,
//            "teacherId": teacherId,
//            "studentId": studentId
//        ]
//    }
//    
//    init(snapshot: FIRDataSnapshot) {
////        self.key = snapshot.key
////        self.ref = snapshot.ref
//        
//        let snapValue = snapshot.value as! [String: AnyObject]
//        
//        self.date = snapValue["datum"] as! String
//        self.startTime = snapValue["startTime"] as! String
//        self.endTime = snapValue["endTime"] as! String
//        self.teacherId = snapValue["teacherId"] as! String
//        self.studentId = snapValue["studentId"] as! String
//    }
//}
