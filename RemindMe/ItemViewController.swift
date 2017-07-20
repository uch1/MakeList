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
    
    var delegate: ItemViewControllerDelegate?
    var item: Item?
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Mark: - Actions 
    
    @IBAction func tapCancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapSave(_ sender: UIBarButtonItem) {
        if let text = titleTextField.text {
            let item = Item.createNewItem(title: text)
            delegate?.addItem(item)
        }
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
