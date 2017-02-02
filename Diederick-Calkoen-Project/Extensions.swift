//
//  Extensions.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 27/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//
// The project uses two extensions. The first to iterate trough a string, this is used to get the right month string when a 
// calendar day is selected. The second extension is to get custom round corners of a views.
//
// First extension: http://stackoverflow.com/questions/24092884/get-nth-character-of-a-string-in-swift-programming-language
// Second extension: http://stackoverflow.com/questions/10167266/how-to-set-cornerradius-for-only-top-left-and-top-right-corner-of-a-uiview

import Foundation
import UIKit

extension String {
    
    var length: Int {
        return self.characters.count
    }
    
    subscript (i: Int) -> String {
        return self[Range(i ..< i + 1)]
    }
    
    func substring(from: Int) -> String {
        return self[Range(min(from, length) ..< length)]
    }
    
    func substring(to: Int) -> String {
        return self[Range(0 ..< max(0, to))]
    }
    
    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
                                            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return self[Range(start ..< end)]
    }
    
}

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
