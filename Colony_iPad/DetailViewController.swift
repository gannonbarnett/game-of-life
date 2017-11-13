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
    @IBOutlet var colony_DetailView: ColonyView!
    
    func configureView() {
        colony_DetailView.setNeedsDisplay()
    }


    var colony : Colony = Colony()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    func evolveColony() {
        colony_DetailView.colony.evolve()
        configureView()
    }
    
}

