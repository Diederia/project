//
//  ContentCollectionViewCell.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 12/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//
// In this class the collection content cell is represented.

import UIKit

class ContentCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlet
    @IBOutlet weak var contentLabel: UILabel!
    
    // MAKR: - Override function
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
