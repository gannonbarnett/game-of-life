//
//  Colony.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import Foundation

class Colony : CustomStringConvertible{
    private var aliveCells = Set<Coordinate>()
    public var cellsWide : Int
    public var windowMIN = Coordinate(xCoor: 0, yCoor: 0)
    public var windowMAX = Coordinate(xCoor: 10, yCoor: 10)
    
    private let absoluteMIN = Coordinate(xCoor: 2, yCoor: 2)
    private let absoluteMAX : Coordinate
    private var temp : String = "Blank"
    private var generation : Int
    private var wrapping : Bool = true
    public var name : String = "Untitled"
    
    public var isDead: Bool { return aliveCells.isEmpty }
    
    init(cellsWide: Int = 10) {
        generation = 0
        self.cellsWide = cellsWide
        windowMIN = Coordinate(xCoor: 0, yCoor: 0)
        windowMAX = Coordinate(xCoor: cellsWide, yCoor: cellsWide)
        //never go bigger than the cells wide.
        absoluteMAX = windowMAX
        aliveCells = Set<Coordinate>()
    }
    
    func getGeneration() -> Int {
        return generation
    }
    
    func setTemplate(_ temp: String) {
        self.temp = temp
    }
    
    func getTemplate() -> String {
        return temp
    }
    
    func setWindow(xMIN: Int, xMAX: Int, yMIN: Int, yMAX: Int) {
        windowMIN = Coordinate(xCoor: xMIN, yCoor: yMIN)
        windowMAX = Coordinate(xCoor: xMAX, yCoor: yMAX)
        print("Window range set to: x:(\(xMIN), \(xMAX)) y:(\(yMIN), \(yMAX))")
    }
    
    func setWindow(origin: Coordinate, width: Int) {
        //make sure it doesn't get set to larger than original colony size.
        let halfWidth = Int(width / 2)
        let calculatedMIN = Coordinate(xCoor: origin.xCoor - halfWidth, yCoor: origin.yCoor - halfWidth)
        let calculatedMAX = Coordinate(xCoor: origin.xCoor + halfWidth, yCoor: origin.yCoor + halfWidth)
        
        if calculatedMIN.isWithinCoordinates(c1: absoluteMIN, c2: absoluteMAX) && calculatedMAX.isWithinCoordinates(c1: absoluteMIN, c2: absoluteMAX) {
            windowMAX = calculatedMAX
            windowMIN = calculatedMIN
        }
    }
    
    func getWindow() {
        print("Window range: \n")
        print("X (\(windowMIN.xCoor), \(windowMAX.xCoor)")
        print("Y (\(windowMIN.yCoor), \(windowMAX.yCoor)")
    }
    
    func getAliveCells() -> Set<Coordinate> {
        return aliveCells
    }
    
    func setCellAlive(_ cell : Coordinate) {
        guard cell.isWithinCoordinates(c1: windowMIN, c2: windowMAX) else {return}
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
    
    func setWrappingTo(_ status: Bool) {
        wrapping = status
    }
    
    func isWrapping() -> Bool {
        return wrapping
    }
    
    func isCellAlive(_ coor: Coordinate) -> Bool{
        let cell = coor
        return aliveCells.contains(cell)
    }
    
    func evolve() throws {
        var relevantCells = [Coordinate : Int]()
        
        for aliveCell in aliveCells {
            var surroundingCells = aliveCell.getSurroundingCells().filter({$0.isWithinCoordinates(c1: windowMIN, c2: windowMAX)})
            
            //Wrapping
            if wrapping {
                if aliveCell.xCoor == 0 {
                    var wrappedCells = Set<Coordinate>()
                    wrappedCells.insert(Coordinate(xCoor: windowMAX.xCoor - 1, yCoor: aliveCell.yCoor + 1))
                    wrappedCells.insert(Coordinate(xCoor: windowMAX.xCoor - 1, yCoor: aliveCell.yCoor))
                    wrappedCells.insert(Coordinate(xCoor: windowMAX.xCoor - 1, yCoor: aliveCell.yCoor - 1))
                    surroundingCells.insert(contentsOf: wrappedCells, at: 0)
                }
                
                if aliveCell.yCoor == 0 {
                    var wrappedCells = Set<Coordinate>()
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor + 1, yCoor: windowMAX.yCoor - 1))
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor, yCoor: windowMAX.yCoor - 1))
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor - 1, yCoor: windowMAX.yCoor - 1))
                    surroundingCells.insert(contentsOf: wrappedCells, at: 0)
                }
                
                if aliveCell.xCoor == windowMAX.xCoor - 1{
                    var wrappedCells = Set<Coordinate>()
                    wrappedCells.insert(Coordinate(xCoor: 0, yCoor: aliveCell.yCoor + 1))
                    wrappedCells.insert(Coordinate(xCoor: 0, yCoor: aliveCell.yCoor))
                    wrappedCells.insert(Coordinate(xCoor: 0, yCoor: aliveCell.yCoor - 1))
                    surroundingCells.insert(contentsOf: wrappedCells, at: 0)
                }
                
                if aliveCell.yCoor == windowMAX.yCoor - 1 {
                    var wrappedCells = Set<Coordinate>()
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor + 1, yCoor: 0))
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor, yCoor: 0))
                    wrappedCells.insert(Coordinate(xCoor: aliveCell.xCoor - 1, yCoor: 0))
                    surroundingCells.insert(contentsOf: wrappedCells, at: 0)
                }
            }
            
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

        //Handle specific cases relevant to further generations
        if nextGen.isEmpty {
            aliveCells = nextGen
            generation += 1
            throw EvolveErrors.Colony_Dead
        }
        
        if nextGen == aliveCells {
            aliveCells = nextGen
            generation += 1
            throw EvolveErrors.Colony_Stagnant
        }
        
        aliveCells = nextGen
        generation += 1
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
    
}
