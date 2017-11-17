//
//  ControlCell.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/11/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class ControlCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
  //      self.frame.height = 100
        self.backgroundColor = UIColor.lightGray
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
