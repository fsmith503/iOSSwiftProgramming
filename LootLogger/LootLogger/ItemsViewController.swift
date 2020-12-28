//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by franklin smith on 12/25/20.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    @IBAction func addNewItem(_ sender: UIButton){
        
    }
    
    @IBAction func toggleEditingMode(_ sender: UIButton){
        // if you are currently in editing mode...
        if isEditing{
            // change text of button to inform user of state
            sender.setTitle("Edit", for: .normal)
            
            //turn off edition mode
            setEditing(false, animated: true)
        } else {
            // change text of button to inform user of state
            sender.setTitle("Done", for: .normal)
            
            // enter editing mode
            setEditing(true, animated: true)
        }
        
    }
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
                return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView,
                             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             // create an instance of UITableViewCell with default appearance
                            //let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
        
                            //get a new or recycled cell
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell",
                                                 for: indexPath)
                                
                            // set the text on the cell with the description of the item
                            // that is at the nth index of items, where n = row this cell
                            // will appear on the tableview
                                
                                let item = itemStore.allItems[indexPath.row]
                                
                                cell.textLabel?.text = item.name
                                cell.detailTextLabel?.text = "$\(item.valueInDollars)"
                                
                                return cell
                                
                             }
    
}


