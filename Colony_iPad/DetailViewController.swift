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
    @IBOutlet weak private var stackView: UIStackView!
    @IBOutlet var colony_DetailView: ColonyView!
    @IBOutlet var ControlsBar: UIView!
    
    func configureView() {
        colony_DetailView.setNeedsDisplay()
        GenNumberLabel.text = "Generation \(colony_DetailView.colony.generation)"
    }


    var colony : Colony = Colony(hasID: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colony_DetailView = self.stackView.subviews[0] as! ColonyView
        ControlsBar = self.stackView.subviews[1]
        colony_DetailView.colony = colony
        self.configureView()
    }

    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
    }
 
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func PlayButtonPressed(_ sender: Any) {
        evolveColony()
    }
    
    @IBAction func PauseButtonPressed(_ sender: Any) {
        //safest way to stop timer. I found without setting timer
        //to nil, the timer sometimes would not stop.
        if timer != nil {
            timer!.invalidate()
            timer = nil
        }
    }
    
    @IBAction func EvolveSpeedChanged(_ sender: Any) {
        
    }
    
    @IBOutlet var EvolveSpeedLabel: UILabel!
    
    @IBOutlet var EvolveSpeedSlider: UISlider!
    
    @IBOutlet var GenNumberLabel: UILabel!
    
    var EvolveSpeedRawValue : Double {
        return Double(EvolveSpeedSlider.value)
    }
    
    //change this value to change max speed of evolve
    let interval_MIN = 0.2
    
    var timer : Timer? = Timer()
    func sliderRawtoTime() -> Double? {
        if EvolveSpeedRawValue < 0.1 {
            return nil
        }
        return EvolveSpeedRawValue < 0.1 ? nil : interval_MIN / EvolveSpeedRawValue
    }
    
    func evolveColony() {
        let c = colony_DetailView.colony
        do {
            try c!.evolve()
            configureView()
        }catch EvolveErrors.Colony_Dead {
            configureView()
            GenNumberLabel.text = "Colony Dead at \(colony_DetailView.colony.generation)"
            GenNumberLabel.backgroundColor = UIColor.red
            return
        }catch EvolveErrors.Colony_Stagnant {
            configureView()
            GenNumberLabel.text = "Colony Stagnant at \(colony_DetailView.colony.generation)"
            GenNumberLabel.backgroundColor = UIColor.red
            return
        }catch {
                print(Error.self)
        }
        
        GenNumberLabel.backgroundColor = UIColor.clear
        guard let interval = sliderRawtoTime() else {
            //do nothing. rawtime is nil. (not continuos)
            return
        }
        
        timer = Timer.scheduledTimer(timeInterval: interval, target: self, selector: #selector(timerEvolve), userInfo: nil, repeats: false)
    }
    
    func timerEvolve() {
        timer?.invalidate()
        evolveColony()
    }
    
}

