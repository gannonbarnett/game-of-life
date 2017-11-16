//
//  NewColonyViewController.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/15/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class NewColonyViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var colonyName : String! {
        return ColonyNameTextField.text!
    }
    
    @IBOutlet var ColonyPickerView: UIPickerView!
    
    @IBOutlet var ColonyNameTextField: UITextField!
    
    @IBAction func CreateButtonPressed(_ sender: Any) {
        guard ColonyNameTextField.text != nil else {
            return
        }
        self.view.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let masterView = self.parent! as! MasterViewController
        masterView.printTest()
        let newColony = Colony()
        newColony.name = "NEWWWWCOLONYBABY"
        masterView.colonies.insert(newColony, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        masterView.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
