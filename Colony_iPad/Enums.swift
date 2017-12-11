//
//  Enums.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/19/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation
import UIKit

enum EvolveErrors : Error {
    case Colony_Dead, Colony_Stagnant
}

struct template {
    var name : String
    var aliveCells : Set<Coordinate>
}

struct TemplateSource {
    static let defaultTemplates : [template] = [template(name: "Glider Fun", aliveCells: [Coordinate(xCoor: 1, yCoor: 2),
                                                                                         Coordinate(xCoor: 2, yCoor: 3),
                                                                                         Coordinate(xCoor: 3, yCoor: 1),
                                                                                         Coordinate(xCoor: 3, yCoor: 2),
                                                                                         Coordinate(xCoor: 3, yCoor: 3)]),
                                                template(name: "Basic Bitch", aliveCells: [Coordinate(xCoor: 1, yCoor: 2),
                                                                                   Coordinate(xCoor: 2, yCoor: 3),
                                                                                   Coordinate(xCoor: 3, yCoor: 1),
                                                                                   Coordinate(xCoor: 3, yCoor: 2),
                                                                                   Coordinate(xCoor: 3, yCoor: 3)]),
                                                template(name: "Boring Blank", aliveCells: [])]
    
    static var customTemplates : [template] = []
    
    static func getTempFromString(_ name : String) -> Set<Coordinate>? {
        for t in TemplateSource.customTemplates {
            if t.name == name {return t.aliveCells}
        }
        for t in TemplateSource.defaultTemplates {
            if t.name == name {return t.aliveCells}
        }
        return nil
    }
    
    static func addNewTemplate(aliveCells: Set<Coordinate>, withName name: String) {
        TemplateSource.customTemplates.append(template(name: name, aliveCells: aliveCells))
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}

enum colors: Int {
    case black = 0x000000
    case white = 0xFFFFFF
    case green = 0x66CC00
    case purple = 0x9900CC
    case red = 0xFF3333
    case blue = 0x0033FF
}

