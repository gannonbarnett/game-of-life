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

struct TemplateSource {
    var templates : [String : Set<Coordinate>] = [:]
    
    //Given templates
    private let gliderSet : Set<Coordinate> = [Coordinate(xCoor: 1, yCoor: 2),
                                       Coordinate(xCoor: 2, yCoor: 3),
                                       Coordinate(xCoor: 3, yCoor: 1),
                                       Coordinate(xCoor: 3, yCoor: 2),
                                       Coordinate(xCoor: 3, yCoor: 3)]
    
    private let basicSet : Set<Coordinate> = [Coordinate(xCoor: 1, yCoor: 2),
                                      Coordinate(xCoor: 2, yCoor: 3),
                                      Coordinate(xCoor: 3, yCoor: 1),
                                      Coordinate(xCoor: 3, yCoor: 2),
                                      Coordinate(xCoor: 3, yCoor: 3)]
    
    private let blankSet : Set<Coordinate> = []

    init() {
        templates["Glider Gun"] = gliderSet
        templates["Basic"] = basicSet
        templates["Blank"] = blankSet
    }
    
    mutating func addNewTemplate(aliveCells: Set<Coordinate>, withName name: String) {
        templates[name] = aliveCells
    }
    
}

var templateSets = TemplateSource()

