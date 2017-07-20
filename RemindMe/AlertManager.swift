//
//  AlertManager.swift
//  RemindMe
//
//  Created by Uchenna  on 7/20/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import Foundation
import CoreData

extension Alert {
    
    
    // MARK: - Methods
    
    static func createNewAlert(time: Date) -> Alert {
        let newAlert = Alert(context: CoreDataHelper.managedContext)
        newAlert.time = time as NSDate
        newAlert.isOn = false
        CoreDataHelper.saveObject()
        
        return newAlert
    }
    
    // TODO: - May not need to fetch alerts
    static func fetchAlert() -> [Alert] {
        let request: NSFetchRequest<Alert> = Alert.fetchRequest()
        let alerts = try! CoreDataHelper.managedContext.fetch(request)
        return alerts
    }
}
