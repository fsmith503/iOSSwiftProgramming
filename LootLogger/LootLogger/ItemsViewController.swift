//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by franklin smith on 12/25/20.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        //tableView.rowHeight = 65
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 65
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    
    
    @IBAction func addNewItem(_ sender: UIBarButtonItem){
//        // make a new index path for th 0th section, last row
//        let lastRow = tableView.numberOfRows(inSection: 0)
//        let indexPath = IndexPath(row: lastRow, section: 0)
//        //Insert this new row into the table
//        tableView.insertRows(at: [indexPath], with: .automatic)
        
        // create a new item and add it to the store
        let newItem = itemStore.createItem()
        
        // figure out where that item is in the array
        if let index = itemStore.allItems.firstIndex(of: newItem){
            let indexPath = IndexPath(row: index, section: 0)
            
            // insert this new row into the table
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
    }
    
//    @IBAction func toggleEditingMode(_ sender: UIButton){
//        // if you are currently in editing mode...
//        if isEditing{
//            // change text of button to inform user of state
//            sender.setTitle("Edit", for: .normal)
//
//            //turn off edition mode
//            setEditing(false, animated: true)
//        } else {
//            // change text of button to inform user of state
//            sender.setTitle("Done", for: .normal)
//
//            // enter editing mode
//            setEditing(true, animated: true)
//        }
//
//    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
                return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView,
                             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             // create an instance of UITableViewCell with default appearance
                            //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
                            //get a new or recycled cell
        //let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 //for: indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCell",
                                                 for: indexPath) as! ItemCell
        
        
        
        // set the text on the cell with the description of the item
        // that is at the nth index of items, where n = row this cell
        // will appear on the tableview
            let item = itemStore.allItems[indexPath.row]
            //cell.textLabel?.text = item.name
            //cell.detailTextLabel?.text = "$\(item.valueInDollars)"
        
        //configure the cell with the Item
        //print("printing item.name below")
        //print(item.name)
        cell.nameLabel.text = item.name
        cell.serialNumberLabel.text = item.serialNumber
        cell.valueLabel.text = "$\(item.valueInDollars)"
            return cell
            
         }
    
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath){
                // if the table view is askig to commit a delete command...
        if editingStyle == .delete {
            let item = itemStore.allItems[indexPath.row]
            
            // remove the item from the store
            itemStore.removeItem(item)
            
            // also remove that row from the table view with an animation
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath){
            // update the model
        itemStore.moveItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        // If the triggered segue is the "showItem" segue
        switch segue.identifier{
        case "showItem":
            // figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row{
                
                //Get the item associated with this row and pass it along
                let item = itemStore.allItems[row]
                let detailViewController = segue.destination as! DetailViewController
                detailViewController.item = item
            }
        default: preconditionFailure("Unexpected segue identifier.")
        }
    }
    
    
}


