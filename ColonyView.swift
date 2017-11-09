//
//  ColonyView.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/8/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit
import CoreGraphics

struct Line {
    var begin = CGPoint.zero
    var end = CGPoint.zero
}


class ColonyView: UIView {
    var c : Colony = Colony(60)
    
    let INSET : CGFloat = 5.0
    let line_WIDTH : CGFloat = 1.0
    
    var cellsInView : Int {
        return c.cellsWide
    }
    
    var cellWidth : CGFloat {
        return (frame.width + 2 * INSET) / CGFloat(cellsInView)
    }
    
    
    func drawLine(_ line : Line) {
        UIColor.black.setStroke()
        let path = UIBezierPath()
        path.lineWidth = line_WIDTH
        path.lineCapStyle = .round
        
        path.move(to: line.begin)
        path.addLine(to: line.end)
        path.stroke()
    }
    
    override func draw(_ rect : CGRect) {
        let w = frame.width
        let interval : CGFloat = (w + 2 * INSET) / CGFloat(cellsInView)
        for x in 0..<cellsInView {
            let start = CGPoint(x: INSET + CGFloat(x) * interval, y: INSET)
            let end = CGPoint(x: CGFloat(x) * interval - INSET, y: w - INSET)
            drawLine(Line(begin: start, end: end))
        }
        
        for y in 0..<cellsInView {
            let start = CGPoint(x: INSET, y: INSET + CGFloat(y) * interval)
            let end = CGPoint(x: w - INSET, y: CGFloat(y) * interval - INSET)
            drawLine(Line(begin: start, end: end))
        }
    }

    func locationToCoor(_ location : CGPoint) -> Coordinate {
        let x = location.x
        let y = location.y
        
        let x_COOR = Int(x / cellWidth)
        let y_COOR = Int(y / cellWidth)
        return Coordinate(xCoor: x_COOR, yCoor: y_COOR)
    }
    /**
    func changeCellColor(_ coor : Coordinate) {
        let CGx = CGFloat(coor.xCoor) * cellWidth + INSET
        let CGy = CGFloat(coor.yCoor) * cellWidth + INSET
        let cell = CGRect(x: CGx, y: CGy, width: cellWidth, height: cellWidth)
        
        let context = self.UIGraphicsGetCurrentContext()!
        UIColor.green.setFill()
        context.addRect(cell)
        context.fill(cell)
        context.strokePath()
        
    } **/
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        
        let location = touch.location(in: self)
        let coorTouched = locationToCoor(location)
        
        c.setCellAlive(coorTouched)
        changeCellColor(coorTouched)
        print("set this cell alive: \(coorTouched)")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
