//
//  NewColonyViewController.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/15/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class NewColonyViewController: UIViewController {
    
    @IBOutlet var ColonyPickerView: UIPickerView!
    @IBOutlet var ColonyNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        ColonyPickerView.dataSource = self
        ColonyPickerView.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var colonyName : String {
        return ColonyNameTextField.text!
    }

    var selectedTemplate : ColonyTemplate {
        let stringPicked = templateNames[ColonyPickerView.selectedRow(inComponent: 0)]
        return ColonyTemplate(rawValue: stringPicked)!
    }
    
    @IBAction func CreateButtonPressed(_ sender: Any) {
        guard ColonyNameTextField.text != nil else {
            return
        }
        self.view.removeFromSuperview()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let masterView = self.parent! as! MasterViewController
        let newColony = Colony()
        newColony.name = colonyName
        newColony.setTemplate(selectedTemplate)
        newColony.activateTemplate()
        masterView.colonies.insert(newColony, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        masterView.tableView.insertRows(at: [indexPath], with: .automatic)
    }
}

extension NewColonyViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templateNames.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return templateNames[row] as String
    }

}
