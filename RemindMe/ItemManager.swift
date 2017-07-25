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
    
    static func createNewItem(title: String, date: Date) -> Item {
        let newItem = Item(context: CoreDataHelper.managedContext)
        newItem.title = title
        newItem.startDate = date as NSDate
        newItem.isCompleted = false
        CoreDataHelper.saveObject()
        
        return newItem
    }
    
    static func saveItem() {
        do {
            try CoreDataHelper.managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func fetchItems() -> [Item] {
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        let items = try! CoreDataHelper.managedContext.fetch(request)
        return items
    }
    
    static func delete(item: Item) {
        CoreDataHelper.managedContext.delete(item)
        CoreDataHelper.saveObject()
    }
    
    

}
