//
//  DetailViewController.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    var colony : Colony? {
        didSet {
            if colony == nil {
                colony = Colony(60)
            }
            self.configureView()
        }
    }
    var allCells = [CellView]()
    
    func configureView() {
        // Update the user interface for the detail item.
        
        for cell in allCells {
            if cell.isAlive { print("HI")}
            
        }
        
    }

    @IBOutlet var colony_DetailView: ColonyView!
    
    override func viewDidLoad() {
       if colony == nil {
            colony = Colony(60)
        }
        super.viewDidLoad()


        /***
        let gap_WIDTH : CGFloat = 2
        let cellsWide = colony!.cellsWide

        let numberGaps : Int = cellsWide - 1
        let gap_SPACE : CGFloat = CGFloat(numberGaps) * gap_WIDTH
        let cellSize = (colonyFrame.width - gap_SPACE) / CGFloat(cellsWide)
    
        for x in 0 ..< cellsWide {
            for y in 0 ..< cellsWide {
                let frame = CGRect(x: cellSize * CGFloat(x) + gap_WIDTH * CGFloat(x), y: cellSize * CGFloat(y) + gap_WIDTH * CGFloat(y), width: cellSize, height: cellSize)
                let cell = CellView(frame: frame)
                
                cell.setCoor(xCoor: x, yCoor: y)
                
                //color of colony
                cell.backgroundColor = UIColor.white
                
                if colony!.isCellAlive(cell.coordinate) {
                    cell.isAlive = true
                    cell.updateColor()
                }
                
                colonyView.addSubview(cell)
                allCells.append(cell)
            }
            
        }
        **/
        self.configureView()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        for aliveCell in allCells.filter({$0.isAlive}) {
            colony?.setCellAlive(aliveCell.coordinate)
        }
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ******
    //MARK: EVOLUTION PROCEDURE
    // ******
    
    func evolveColony(timed : Bool = false) {
        guard let oldColony = colony else {return}
        
        colony = colony!
        oldColony.aliveCells = colony!.aliveCells
        
        colony!.resetColony()
        //clear old colony, only set cells alive that are still alive
        //at time of evolve button pressed.
        for cell in allCells{
            if cell.isAlive {
                colony!.setCellAlive(cell.coordinate)
                cell.isAlive = false
                cell.updateColor()
            }
        }
        
        colony!.evolve()
        for cell in allCells {
            if colony!.isCellAlive(cell.coordinate) {
                cell.isAlive = true
                cell.updateColor()
            }
        }

        
        if timed { //make new timer
            timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerEvolve), userInfo: nil, repeats: false)
        }
        
    }
    
    // ******
    //MARK: EVOLVE CONTINOUSLY CONFIGURATION
    // ******
    var timer : Timer? = Timer()
    //made optional for safe stopping. See
    //pauseButtonTouched function for details.
    
    let interval_MAX = 2.0
    var interval : Double = 0.5 * 2.0
    
    
    func timerEvolve() {
        timer?.invalidate()
        evolveColony(timed: true)
        
    }
    
    
}

