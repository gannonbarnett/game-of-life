//
//  MasterViewController.swift
//  Colony_iPad
//
//  Created by Gannon Barnett on 11/6/17.
//  Copyright © 2017 Barnett. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UIPopoverPresentationControllerDelegate {

    var detailViewController: DetailViewController? = nil
    var colonies = [Colony]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        /*
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openPopUpView(_:)))
        
        self.navigationItem.rightBarButtonItem = addButton */
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
            
            //initially have one colony already in table, already selected.
            let firstColony = Colony()
            firstColony.name = "First Colony!"
            colonies.append(firstColony)
            self.detailViewController?.colony = colonies[0]
            let firstIndex = IndexPath(row: 0, section: 0)
            let scroll = UITableViewScrollPosition(rawValue: 0)! //unsure what this does, but it is just placeholder.
            self.tableView.selectRow(at: firstIndex, animated: false, scrollPosition: scroll)
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        
        let firstIndex = IndexPath(row: 0, section: 0)
        let scroll = UITableViewScrollPosition(rawValue: 0)! //unsure what this does, but it is just placeholder.
        self.tableView.selectRow(at: firstIndex, animated: false, scrollPosition: scroll)
        self.detailViewController?.colony = colonies[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let row = self.tableView.indexPathForSelectedRow?.row {
                let selectedColony = colonies[row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.colony = selectedColony
                controller.colony_DetailView = detailViewController?.colony_DetailView
              //  controller.colony_DetailView.colony = selectedColony
              //  print(UIColor(rgb: selectedColony.colonyColor).description)
                controller.configureView()
                controller.colony_DetailView.setNeedsDisplay()
                //controller.colony_DetailView.updateColors()
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
    
    func showColony(atRow row: Int) {
        let index = IndexPath(row: row, section: 0)
        let scroll = UITableViewScrollPosition(rawValue: 0)!
        self.tableView.selectRow(at: index, animated: true, scrollPosition: scroll)

        let selectedColony = colonies[row]
        let navController = self.splitViewController!.viewControllers[1] as! UINavigationController
        let controller =
            (navController).topViewController as! DetailViewController
        controller.colony = selectedColony
        controller.colony_DetailView = detailViewController?.colony_DetailView
        controller.title = selectedColony.name
        controller.configureView()
        controller.colony_DetailView.updateColors()
        controller.view.backgroundColor = UIColor.black
    }
    // MARK: - Table View
    
    func updateColonyView() {
        let navController = self.splitViewController!.viewControllers[1] as! UINavigationController
        let controller =
            (navController).topViewController as! DetailViewController
        controller.colony_DetailView.updateColors()
        controller.colony_DetailView.setNeedsDisplay()
    }
    
    //Control Cell
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colonies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let colony = colonies[indexPath.row]
        cell.textLabel!.text = "\(colony.name)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            colonies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let settingsVC = storyboard.instantiateViewController(withIdentifier: "settingsVC") as! SettingsTableVC
        
        let colony = colonies[indexPath.row]
        self.navigationController?.pushViewController(settingsVC, animated: true)
        //(self.navigationController?.topViewController as! SettingsTableVC).colonyRecieved = colony
    }
}

