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




