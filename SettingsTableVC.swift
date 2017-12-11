//
//  SettingsTableVC.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 12/10/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class SettingsTableVC: UITableViewController {

    var colonyRecieved : Colony? = nil
    
    var masterVC : MasterViewController {
        return self.navigationController?.viewControllers[0] as! MasterViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.colonyName.text = colonyRecieved?.name
        self.gridEnabled_Switch.isOn = colonyRecieved!.gridEnabled
    }
    
    @IBOutlet var colonyName: UITextField!
    @IBAction func colonyName_TextFieldChanged(_ sender: Any) {
        colonyRecieved!.name = colonyName.text!
        masterVC.updateColonyView()
    }
    
    @IBOutlet var gridEnabled_Switch: UISwitch!
    @IBAction func gridEnabled_SwitchChanged(_ sender: Any) {
        colonyRecieved!.gridEnabled = gridEnabled_Switch.isOn
        masterVC.updateColonyView()
    }
    
    @IBOutlet var redCell_Button: UIButton!
    @IBOutlet var greenCell_Button: UIButton!
    @IBOutlet var blueCell_Button: UIButton!
    @IBOutlet var whiteCell_Button: UIButton!
    @IBOutlet var blackCell_Button: UIButton!
    
    func clearCellColorSelection() {
        redCell_Button.layer.borderColor = UIColor.clear.cgColor
        greenCell_Button.layer.borderColor = UIColor.clear.cgColor
        blueCell_Button.layer.borderColor = UIColor.clear.cgColor
        whiteCell_Button.layer.borderColor = UIColor.clear.cgColor
        blackCell_Button.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func redCell_ButtonTouched(_ sender: Any) {
        colonyRecieved?.cellColor = colors.red.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func greenCell_ButtonTouched(_ sender: Any) {
        colonyRecieved?.cellColor = colors.green.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func blueCell_ButtonTouched(_ sender: Any) {
        colonyRecieved?.cellColor = colors.blue.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func whiteCell_ButtonTouched(_ sender: Any) {
        colonyRecieved?.cellColor = colors.white.rawValue
        masterVC.updateColonyView()
    }

    @IBAction func blackCell_ButtonTouched(_ sender: Any) {
        colonyRecieved?.cellColor = colors.black.rawValue
        masterVC.updateColonyView()
    }
    
    
    @IBOutlet var redColony_Button: UIButton!
    @IBOutlet var greenColony_Button: UIButton!
    @IBOutlet var blueColony_Button: UIButton!
    @IBOutlet var whiteColony_Button: UIButton!
    @IBOutlet var blackColony_Button: UIButton!
    
    @IBAction func redColony_ButtonTouched(_ sender: Any) {
        colonyRecieved?.colonyColor = colors.red.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func greenColony_ButtonTouched(_ sender: Any) {
        colonyRecieved?.colonyColor = colors.green.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func blueColony_ButtonTouched(_ sender: Any) {
        colonyRecieved?.colonyColor = colors.blue.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func whiteColony_ButtonTouched(_ sender: Any) {
        colonyRecieved?.colonyColor = colors.white.rawValue
        masterVC.updateColonyView()
    }
    
    @IBAction func blackColony_ButtonTouched(_ sender: Any) {
        colonyRecieved?.colonyColor = colors.black.rawValue
        masterVC.updateColonyView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
