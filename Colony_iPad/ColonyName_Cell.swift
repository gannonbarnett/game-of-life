//
//  ColonyName_Cell.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 12/7/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class ColonyName_Cell: UITableViewCell {

    @IBOutlet var Name_TextField: UITextField!
    
    func getName() -> String? {
        return Name_TextField.text
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
