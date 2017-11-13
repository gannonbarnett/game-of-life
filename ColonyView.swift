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
    
    public var colony : Colony = Colony(10)
    public let INSET : CGFloat = 5.0
    private let line_WIDTH : CGFloat = 1.0

    private var cellsInView : Int {
        return colony.cellsWide
    }
    
    private var cellWidth : CGFloat {
        return (frame.width - (2 * INSET)) / CGFloat(cellsInView)
    }
    
    private func drawLine(_ line : Line) {
        UIColor.darkGray.setStroke()
        let path = UIBezierPath()
        path.lineWidth = line_WIDTH
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect : CGRect) {
        let w = frame.width
        
        for cell in colony.aliveCells {
            colorCellAlive(cell)
        }
        
        for x in 0 ..< cellsInView + 1 {
            let start = CGPoint(x: INSET + CGFloat(x) * cellWidth, y: INSET)
            let end = CGPoint(x: CGFloat(x) * cellWidth + INSET, y: w - INSET)
            drawLine(Line(begin: start, end: end))
        }
        
        for y in 0 ..< cellsInView + 1 {
            let start = CGPoint(x: INSET, y: INSET + CGFloat(y) * cellWidth)
            let end = CGPoint(x: w - INSET, y: CGFloat(y) * cellWidth + INSET)
            drawLine(Line(begin: start, end: end))
        }
    }

    private func locationToCoor(_ location : CGPoint) -> Coordinate {
        let x = location.x
        let y = location.y
        //needs to be changed to always round down. 
        
        let x_COOR = Int(Double(x / cellWidth).rounded(.down))
        let y_COOR = Int(Double(y / cellWidth).rounded(.down))
        return Coordinate(xCoor: x_COOR, yCoor: y_COOR)
    }
    
    private func colorCellAlive(_ coor : Coordinate) {
        
        let CGx = CGFloat(coor.xCoor) * cellWidth + INSET
        let CGy = CGFloat(coor.yCoor) * cellWidth + INSET
        let cell = CGRect(x: CGx, y: CGy, width: cellWidth, height: cellWidth)
        
        let b = UIBezierPath(rect: cell)
        UIColor.red.set()
        b.fill()
        b.stroke()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self)
        let coorTouched = locationToCoor(location)
        
        colony.isCellAlive(coorTouched) ? colony.setCellDead(coorTouched) : colony.setCellAlive(coorTouched)
        setNeedsDisplay()
    }


}
