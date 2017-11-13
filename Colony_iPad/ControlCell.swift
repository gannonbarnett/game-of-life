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
    
/**
    @IBAction func speedSliderMoved(_ sender: Any) {
        
    }
    @IBAction func playTouched(_ sender: Any) {
        
    }
    
    @IBAction func pauseTouched(_ sender: Any) {
    }
    
    @IBAction func evolveOnceTouched(_ sender: Any) {
        detailViewController?.evolveColony()
    }
    
    @IBAction func resetTouched(_ sender: Any) {
    }

    **/
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
