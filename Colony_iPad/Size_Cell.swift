//
//  Size_Cell.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 12/7/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class Size_Cell: UITableViewCell {

    public var size : Int = 0
    
    @IBOutlet var Size_Slider: UISlider!
    @IBAction func Size_SliderChanged(_ sender: Any) {
        updateColonySizeLabel()
    }
    
    @IBOutlet var Size_Label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        updateColonySizeLabel()
    }
    
    private func updateColonySizeLabel() {
        size = Int(Size_Slider.value * 95) + 5
        Size_Label.text = String(size)
    }

}
