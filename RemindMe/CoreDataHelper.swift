//
//  CoreDataHelper.swift
//  RemindMe
//
//  Created by Uchenna  on 7/18/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataHelper {
    
    // MARK: - Properties
    
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
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

