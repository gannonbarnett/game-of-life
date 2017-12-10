//
//  NewColonyTableVC.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 12/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class NewColonyTableVC: UITableViewController {
    
    let noNameAlert = UIAlertController(title: "No Name Entererd", message: "Please enter a name for your colony", preferredStyle: UIAlertControllerStyle.alert)
    
    let noTemplateAlert = UIAlertController(title: "No Template Selected", message: "Please select a template for your colony", preferredStyle: UIAlertControllerStyle.alert)

    override func viewDidLoad() {
        super.viewDidLoad()
        noNameAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        noTemplateAlert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return TemplateSource.defaultTemplates.count
        case 3:
            return TemplateSource.customTemplates.count > 0 ? TemplateSource.customTemplates.count : 1
        default:
            return 0
        }
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "colony name"
        case 1:
            return "size"
        case 2:
            return "templates"
        case 3:
            return "custom templates"
        default:
            return "error section invalid"
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "colonyName", for: indexPath)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "size", for: indexPath)
            return cell
        }
        
        if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "template", for: indexPath)
            let row = indexPath.row
            cell.textLabel!.text = TemplateSource.defaultTemplates[row].name
            return cell
        }
        
        if indexPath.section == 3 {
            var cell : UITableViewCell? = nil
            if !TemplateSource.customTemplates.isEmpty {
                cell = tableView.dequeueReusableCell(withIdentifier: "customTemplate", for: indexPath)
                let row = indexPath.row
                cell!.textLabel!.text = TemplateSource.customTemplates[row].name
            } else {
                cell = tableView.dequeueReusableCell(withIdentifier: "noTemplate", for: indexPath)
            }
            return cell!
        }
        
        return UITableViewCell()
    }
    
    var colonyName : String? {
        let nameCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! ColonyName_Cell
        return nameCell.getName()
    }
    
    var colonySize : Int {
        let sizeCell = tableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! Size_Cell
        return sizeCell.size
    }
    
    var selectedTemplate : String? {
        if let index = tableView.indexPathForSelectedRow {
            return tableView.cellForRow(at: index)!.textLabel!.text!
        }
        return nil
    }
    
    @IBAction func Create_ButtonTouched(_ sender: Any) {
        let navController = self.parent! as! UINavigationController
        let masterView = navController.viewControllers[0] as! MasterViewController
        let newColony = Colony(cellsWide: colonySize)
        
        guard colonyName != "" else {
            self.present(noNameAlert, animated: true, completion: nil)
            return
        }
        newColony.name = colonyName!
        
        guard selectedTemplate != nil else {
            self.present(noTemplateAlert, animated: true, completion: nil)
            return
        }
        newColony.setTemplate(selectedTemplate!)
        
        activateTemplateOf(colony: newColony)
        masterView.colonies.insert(newColony, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        masterView.tableView.insertRows(at: [indexPath], with: .automatic)
        navController.popViewController(animated: true)
        masterView.showColony(atRow: 0)
    }
    
    func activateTemplateOf(colony: Colony) {
        let temp : String = colony.getTemplate()
        for cell in TemplateSource.getTempFromString(temp)! {
            colony.setCellAlive(cell)
        }
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

     }
}
