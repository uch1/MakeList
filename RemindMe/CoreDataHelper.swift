//
//  CoreDataHelper.swift
//  RemindMe
//
//  Created by Uchenna  on 7/18/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataHelper {
    
    // MARK: - Properties
    
    static let persistentContainer = CoreDataStack.sharedInstance.persistentContainer
    static let managedContext = persistentContainer.viewContext
    
    
    
    // MARK: - Methods 
    
    static func saveObject() {
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save \(error)")
        }
    }
    
    static func delete(object: NSManagedObject) {
        managedContext.delete(object)
        saveObject()
    }

}

