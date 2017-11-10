//
//  Colony.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation

class Colony : CustomStringConvertible{
    private var generation : Int
    public var aliveCells = Set<Coordinate>()
    public var cellsWide : Int
    private var windowMIN = Coordinate(xCoor: 0, yCoor: 0)
    private var windowMAX = Coordinate(xCoor: 10, yCoor: 10)
    
    var isDead: Bool { return aliveCells.isEmpty }
    
    init(_ cellsWide: Int = 10) {
        generation = 0
        self.cellsWide = cellsWide
        windowMIN = Coordinate(xCoor: 0, yCoor: 0)
        windowMAX = Coordinate(xCoor: cellsWide, yCoor: cellsWide)
        aliveCells = Set<Coordinate>()
    }
    
    func setWindow(xMIN: Int, xMAX: Int, yMIN: Int, yMAX: Int) {
        windowMIN = Coordinate(xCoor: xMIN, yCoor: yMIN)
        windowMAX = Coordinate(xCoor: xMAX, yCoor: yMAX)
        print("Window range set to: x:(\(xMIN), \(xMAX)) y:(\(yMIN), \(yMAX))")
    }
    
    func getWindow() {
        print("Window range: \n")
        print("X (\(windowMIN.xCoor), \(windowMAX.xCoor)")
        print("Y (\(windowMIN.yCoor), \(windowMAX.yCoor)")
    }
    
    func setCellAlive(_ cell : Coordinate) {
        aliveCells.insert(cell)
    }
    
    func setCellDead(_ cell : Coordinate) {

        if aliveCells.contains(cell) {
            aliveCells.remove(cell)
        }
    }
    
    func resetColony() {
        aliveCells.removeAll()
    }
    
    var description: String {
        var s : String = "Generation #" + String(generation) + "\n"
        
        for y in windowMIN.yCoor ... windowMAX.yCoor {
            for x in windowMIN.xCoor ... windowMAX.xCoor {
                if aliveCells.contains(Coordinate(xCoor: x, yCoor: y)) {
                    s.append("* ")
                } else {
                    s.append("- ")
                }
            }
            s.append("\n")
        }
        
        return s
    }
    
    func isCellAlive(_ coor: Coordinate) -> Bool{
        let cell = coor
        return aliveCells.contains(cell)
    }
    
    func evolve() {
        var relevantCells = [Coordinate : Int]()
        
        for aliveCell in aliveCells {
            //I have window mode turned off for the app-- so that alive cells don't exist outside
            //of the view area. Delete this line and the window will be just a window-- alive
            //cells will exist outside of view.
            
            let surroundingCells = aliveCell.getSurroundingCells().filter({$0.isWithinCoordinates(c1: windowMIN, c2: windowMAX)})
            
            for cell in surroundingCells {
                if relevantCells.keys.contains(cell)  {
                    relevantCells[cell]! += 1
                } else {
                    relevantCells[cell] = 1
                }
            }
        }
        
        var nextGen = Set<Coordinate>()
        for cell in relevantCells.keys {
            let number = relevantCells[cell]
            if number == 3 {
                nextGen.insert(cell)
            } else if number == 2 && aliveCells.contains(cell) {
                nextGen.insert(cell)
            }
        }
        
        aliveCells = nextGen
        generation += 1
    }
}
