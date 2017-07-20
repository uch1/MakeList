//
//  ItemManager.swift
//  RemindMe
//
//  Created by Uchenna  on 7/20/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import Foundation
import CoreData

extension Item {
    
    
    // MARK: - Methods
    
    static func createNewItem(title: String) -> Item {
        let newItem = Item(context: CoreDataHelper.managedContext)
        newItem.title = title
        newItem.startDate = NSDate()
        newItem.isCompleted = false
        CoreDataHelper.saveObject()
        
        return newItem
    }
    
    static func fetchItems() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let items = try! CoreDataHelper.managedContext.fetch(request)
        return items
    }

}
