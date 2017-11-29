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
    
    func activateTemplateOf(colony: Colony) {
        let temp : String = colony.getTemplate()
        colony.aliveCells = templateSets.templates[temp]!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
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
    
    var selectedTemplate : String {
        let templateNames = Array(templateSets.templates.keys)
        return templateNames[ColonyPickerView.selectedRow(inComponent: 0)]
    }
    
    @IBAction func CreateButtonPressed(_ sender: Any) {
        guard ColonyNameTextField.text != nil else {
            return
        }
        self.view.removeFromSuperview()
        let masterView = self.parent! as! MasterViewController
        let newColony = Colony()
        newColony.name = colonyName
        newColony.setTemplate(selectedTemplate)
        activateTemplateOf(colony: newColony)
        masterView.colonies.insert(newColony, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        masterView.tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    @IBAction func CancelButtonPressed(_ sender: Any) {
        self.view.removeFromSuperview()
    }
}

extension NewColonyViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return templateSets.templates.count 
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let templateNames = Array(templateSets.templates.keys)
        return templateNames[row] as String
    }

}
