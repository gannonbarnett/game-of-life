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
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(openPopUpView(_:)))
        self.navigationItem.rightBarButtonItem = addButton
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
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openPopUpView(_ sender: Any) {
        let NewColonyVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewColonyPopUpID") as! NewColonyViewController
        self.addChildViewController(NewColonyVC)
        NewColonyVC.view.frame = self.view.frame
        self.view.addSubview(NewColonyVC.view)
        NewColonyVC.didMove(toParentViewController: self)
    
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let selectedColony = colonies[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.colony = selectedColony
                controller.colony_DetailView = detailViewController?.colony_DetailView
                controller.colony_DetailView.colony = selectedColony
                controller.configureView()
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        
    }
    
    // MARK: - Table View
    
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        // guard indexPath.section == 1 else {return false}
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            colonies.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
}

