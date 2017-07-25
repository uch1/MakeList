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
    
    var delegate: ItemViewControllerDelegate?
    var item: Item?
    
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


