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
    
    static func dateAtStartOfDay(date: NSDate?) -> Date {
        let calendar = Calendar.current
        let _ = calendar.timeZone
        
        guard let date = date else { return Date() }
        var dateComponents = calendar.dateComponents([.day, .month, .year], from: date as Date)
        dateComponents.hour = 0; dateComponents.minute = 0; dateComponents.second = 0
        
        guard let dateFromComponents = calendar.date(from: dateComponents) else { return Date() }
        return dateFromComponents
    }
    
    

}
