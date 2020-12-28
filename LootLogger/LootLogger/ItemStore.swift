//
//  ItemStore.swift
//  LootLogger
//
//  Created by franklin smith on 12/26/20.
//

import UIKit

class ItemStore{
    
    var allItems = [Item]()
    
//    init() {
//        for _ in 0..<15{
//            createItem()
//        }
//    }
    
    
    func moveItem(from fromIndex: Int, to toIndex: Int){
        if fromIndex == toIndex{
            return
        }
        // get reference to object being moved so you can reinsert it
        let movedItem = allItems[fromIndex]
        
        // remove item from array
        allItems.remove(at: fromIndex)
        
        // insert item in array at new location
        allItems.insert(movedItem, at: toIndex)
    
    }
    
    func removeItem(_ item: Item){
        if let index = allItems.firstIndex(of: item){
            allItems.remove(at: index)
        }
    }
    
    @discardableResult func createItem() -> Item {
        let newItem = Item(random: true)
        allItems.append(newItem)
        return newItem
    }
    
}




