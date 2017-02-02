//
//  CustomCell.swift
//  Diederick-Calkoen-Project
//
//  Created by Diederick Calkoen on 18/01/17.
//  Copyright © 2017 Diederick Calkoen. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var hoursLabel: UILabel!
    
    // MARK: - Override functions
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
