//
//  UsersTVCell.swift
//
//
//  Created by Jeff Devine on 4/26/15.
//  Copyright (c) 2015 Rapid Response Emergency Systems. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UsersTVCell: PFTableViewCell {

    
    
    @IBOutlet weak var userDisplayName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
