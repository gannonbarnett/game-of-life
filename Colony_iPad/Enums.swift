//
//  Enums.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/19/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation

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

