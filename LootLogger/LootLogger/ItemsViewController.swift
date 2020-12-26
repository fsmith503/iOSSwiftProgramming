//
//  ItemsViewController.swift
//  LootLogger
//
//  Created by franklin smith on 12/25/20.
//

import UIKit

class ItemsViewController: UITableViewController {
    
    var itemStore: ItemStore!
    
    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
                return itemStore.allItems.count
    }

    override func tableView(_ tableView: UITableView,
                             cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                             // create an instance of UITableViewCell with default appearance
                            let cell = UITableViewCell(style: .value1, reuseIdentifier: "UITableViewCell")
                                
                            // set the text on the cell with the description of the item
                            // that is at the nth index of items, where n = row this cell
                            // will appear on the tableview
                                
                                let item = itemStore.allItems[indexPath.row]
                                
                                cell.textLabel?.text = item.name
                                cell.detailTextLabel?.text = "$\(item.valueInDollars)"
                                
                                return cell
                                
                             }
    
}


