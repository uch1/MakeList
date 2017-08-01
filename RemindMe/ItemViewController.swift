//
//  ItemViewController.swift
//  RemindMe
//
//  Created by Uchenna  on 7/20/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit

protocol ItemViewControllerDelegate {
    func addItem(_ item: Item)
}

class ItemViewController: UIViewController {
    
    // MARK: - Properties
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var alertTableView: UITableView!
    
    var delegate: ItemViewControllerDelegate?
    var item: Item?
    
    let alertDetails = [["Alert"], ["None", "At time of event", "1 minute before", "5 minutes before", "10 minutes"]]
    
    var selectedStartDate: Date!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        if let item = item, let date = item.startDate {
            titleTextField.text = item.title
            navigationItem.leftBarButtonItem = nil
            navigationItem.rightBarButtonItem = nil
            datePicker.date = date as Date
            selectedStartDate = datePicker.date
        } else {
            print("item is nil")
            selectedStartDate = datePicker.date
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            delegate?.addItem(item)
        }
    }
    
    @IBAction func selectDate(_ sender: UIDatePicker) {
        selectedStartDate = sender.date
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
//        if section == 0 {
//            return 1
//        } else {
//            return 5
//        }
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
        }
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

















