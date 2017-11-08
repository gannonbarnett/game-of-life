//
//  cellView.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class CellView : UIView {
    var coordinate = Coordinate(xCoor: 0, yCoor: 0) //is there a way to change the init
    var isAlive : Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        updateColor()
        self.isUserInteractionEnabled = true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        cellTapped()
    }
    
    func cellTapped ()  {
        isAlive = !isAlive
        updateColor()
    }

    
    func setCoor(xCoor: Int, yCoor: Int) {
        self.coordinate = Coordinate(xCoor: xCoor, yCoor: yCoor)
    }
    
    func updateColor() {
        if isAlive {
            self.backgroundColor = UIColor.green
        } else {
            self.backgroundColor = UIColor.white
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
