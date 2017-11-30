//
//  ColonyView.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/8/17.
//  Copyright © 2017 Barnett. All rights reserved.
//
import UIKit
import CoreGraphics
import Foundation

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}


class ColonyView: UIView {
    
    public var colony : Colony = Colony(cellsWide: 10)
    public let INSET : CGFloat = 5.0
    private let line_WIDTH : CGFloat = 1.0
    
    var gridEnabled : Bool = false
    
    let cellColor = UIColor(red:0.11, green:0.31, blue:0.43, alpha:1.0)
    let colonyColor = UIColor(red:0.87, green:0.86, blue:0.63, alpha:1.0)
    
    func setGridVisible(_ status: Bool) {
        gridEnabled = status
    }
    
    private var cellsInView : Int {
        return colony.cellsWide
    }
    
    private var cellWidth : CGFloat {
        return (frame.width - (2 * INSET)) / CGFloat(cellsInView)
    }
    
    private func drawLine(_ line : Line, withColor color: UIColor) {
        color.set()
        let path = UIBezierPath()
        path.lineWidth = line_WIDTH
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect : CGRect) {
        let w = frame.width
        
        for cell in colony.getAliveCells() {
         //   if cell.xCoor < colony.cellsWide && cell.yCoor < colony.cellsWide {
                colorCellAlive(cell)
         //   }
        }
        var color : UIColor = colonyColor
        if gridEnabled { color = UIColor.black }
        for x in 0 ..< cellsInView + 1 {
            let start = CGPoint(x: INSET + CGFloat(x) * cellWidth, y: INSET)
            let end = CGPoint(x: CGFloat(x) * cellWidth + INSET, y: w - INSET)
            drawLine(Line(begin: start, end: end), withColor: color)
        }
        
        for y in 0 ..< cellsInView + 1 {
            let start = CGPoint(x: INSET, y: INSET + CGFloat(y) * cellWidth)
            let end = CGPoint(x: w - INSET, y: CGFloat(y) * cellWidth + INSET)
            drawLine(Line(begin: start, end: end), withColor: color)
        }

    }
    
    private func locationToCoor(_ location : CGPoint) -> Coordinate {
        let x = location.x - INSET
        let y = location.y - INSET
        
        let x_COOR = Int((x / cellWidth))
        let y_COOR = Int((y / cellWidth))
        return Coordinate(xCoor: x_COOR, yCoor: y_COOR)
    }
    
    private func colorCellAlive(_ coor : Coordinate) {
        
        let CGx = CGFloat(coor.xCoor) * cellWidth + INSET
        let CGy = CGFloat(coor.yCoor) * cellWidth + INSET
        let cell = CGRect(x: CGx, y: CGy, width: cellWidth, height: cellWidth)
        
        
        let b = UIBezierPath(rect: cell)
        cellColor.set()
        b.fill()
        b.stroke()
    }
    
    var lastCoordinate : Coordinate? = nil
    
    var dragStateAlive : Bool = true
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let coorTouched = locationToCoor(location)

        dragStateAlive = colony.isCellAlive(coorTouched)
        colony.isCellAlive(coorTouched) ? colony.setCellDead(coorTouched) : colony.setCellAlive(coorTouched)
        lastCoordinate = coorTouched
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: self)
        let coorTouched = locationToCoor(location)
        
        if lastCoordinate != coorTouched {
            dragStateAlive ? colony.setCellDead(coorTouched) : colony.setCellAlive(coorTouched)
            setNeedsDisplay()
        }
        lastCoordinate = coorTouched
    }
}
