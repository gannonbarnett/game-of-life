//
//  coordinate.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation

struct Coordinate : Hashable, CustomStringConvertible{
    public var xCoor : Int
    public var yCoor : Int
    
    var description: String {
        return "(" + String(xCoor) + ", " + String(yCoor) + ")"
    }
    
    var hashValue: Int {
        return xCoor * 1000 + yCoor
    }
    
    static func == (lhs: Coordinate, rhs: Coordinate) -> Bool {
        return lhs.xCoor == rhs.xCoor && lhs.yCoor == rhs.yCoor
    }
    
    func getSurroundingCells() -> [Coordinate] {
        var cells = [Coordinate]()
        for i in -1...1 {
            for j in -1...1 {
                if xCoor + i > 0 || yCoor + j > 0 { //make sure coordinates are positive
                    if i != 0 || j != 0 { //don't add cell itself
                        cells.append(Coordinate(xCoor: xCoor + i, yCoor: yCoor + j))
                    }
                }
                
            }
        }
        return cells
    }
    
    func isWithinCoordinates(c1: Coordinate, c2: Coordinate) -> Bool{
        return (xCoor >= c1.xCoor && xCoor < c2.xCoor) && (yCoor >= c1.yCoor && yCoor < c2.yCoor)
    }
}
