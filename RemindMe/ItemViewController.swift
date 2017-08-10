//
//  ItemViewController.swift
//  RemindMe
//
//  Created by Uchenna  on 7/20/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit
import UserNotifications

protocol ItemViewControllerDelegate {
    func addItem(_ item: Item)
}

class ItemViewController: UIViewController, UITextFieldDelegate {
    
    enum AlertTime: Int {
    case none
    case atTimeOfEvent
    case oneMinuteBefore
    case fiveMinutesBefore
    case tenMinutesBefore
    }
    
    
    // MARK: - Properties
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alertTableView: UITableView!
    
    var selectedIndex: IndexPath?
    var delegate: ItemViewControllerDelegate?
    var item: Item?
    var selectedStartDate: Date!
    var selectedRow = 0
    let alertDetails = [["Alert"], ["None", "At time of event", " 1 minute before", "5 minutes before", "10 minutes before"]]
    
    var alertMinutes: Int? {
        var alertMinutes: Int?
        if let alertTime = AlertTime(rawValue: selectedRow) {
            switch alertTime {
            case .none: alertMinutes = nil
            case .atTimeOfEvent: alertMinutes = 0
            case .oneMinuteBefore: alertMinutes = -1
            case .fiveMinutesBefore: alertMinutes = -5
            case .tenMinutesBefore: alertMinutes = -10
            }
        }
        return alertMinutes
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: - delete if it doesn't work
        titleTextField.delegate = self

        if let item = item, let date = item.startDate {
            titleTextField.text = item.title
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
            datePicker.date = date as Date
            selectedStartDate = datePicker.date
            if let alert = item.alert {
                selectedRow = Int(alert.level)
            }
        } else {
            print("item is nil")
            selectedStartDate = datePicker.date
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Hide keyboard when user touches outside of keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    // Hide the keyboard when a user presses the return key
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.titleTextField.resignFirstResponder()
        return (true)
    }
    
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            item?.title = titleTextField.text
            item?.startDate = selectedStartDate as NSDate
            Item.saveItem()
        }
    }

    
    
    // Mark: - Actions 
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        if let text = titleTextField.text {
            let item = Item.createNewItem(title: text, date: selectedStartDate)
            Alert.insertAlertWithItem(item, level: selectedRow)
            if let alertMinutes = alertMinutes {
                scheduleNotification(title: text, date: selectedStartDate, minutes: alertMinutes)
            }
            
            delegate?.addItem(item)
        }
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        selectedStartDate = sender.date
    }
    
    
    private func scheduleNotification(title: String, date: Date, minutes: Int) {
        let content = UNMutableNotificationContent()
        
        content.title = title
        content.subtitle = "Hey, don't forget!"
        content.body = " "
        
        let newDate = createNewDate(fromDate: date, withMinutesAlert: minutes)
        if let newDate = newDate {
            let minutes = Calendar.current.component(.minute, from: newDate)
            var dateComponents = DateComponents()
            dateComponents.minute = minutes
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
    
    private func createNewDate(fromDate: Date, withMinutesAlert: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.setValue(withMinutesAlert, for: .minute)
        let newDate = Calendar.current.date(byAdding: dateComponents, to: fromDate)
        return newDate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
   

}

extension ItemViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return alertDetails.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alertDetails[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "alertTitleIdentifier", for: indexPath)
            let firstAlertDetailArray = alertDetails[0]
            cell.textLabel?.text = firstAlertDetailArray[indexPath.row]
            
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "alertTimeIdentifier", for: indexPath)
            let secondAlertDetailArray = alertDetails[1]
            cell.textLabel?.text = secondAlertDetailArray[indexPath.row]
            
            if selectedRow == indexPath.row {
                cell.accessoryType = .checkmark
            }
        default: break
        }
        return cell
    }

    

}

extension ItemViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 1 {
            selectRow(in: tableView, at: indexPath)
            selectedRow = indexPath.row
        }
        self.selectedIndex = indexPath
    }
    
  

}

extension UITableViewDelegate {
    
    func selectRow(in tableView: UITableView, at indexPath: IndexPath) {
        let section = indexPath.section
        let numberOfRows = tableView.numberOfRows(inSection: section)
        for row in 0..<numberOfRows {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: section)) {
                cell.accessoryType = row == indexPath.row ? .checkmark : .none
            }
        }
    }
}

















