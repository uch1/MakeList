//
//  ItemsViewController.swift
//  RemindMe
//
//  Created by Uchenna  on 7/17/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController {

    // MARK: - Properties 
    
    let itemCellIdentifier = "itemCellIdentifier"
    @IBOutlet weak var itemsTableView: UITableView!
    
    var items = [Item]() {
        didSet {
            itemsTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = Item.fetchItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Actions
    
    
    
    
    
    
    
    // MARK: - Navigation 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToItem" {
            if let destination = segue.destination as? UINavigationController, let itemVC = destination.visibleViewController as? ItemViewController {
                itemVC.delegate = self
            }
        }
    }

}

// MARK: - UITableViewDataSource

extension ItemsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellIdentifier", for: indexPath)
        let item = items[indexPath.row]
        cell.textLabel?.text = item.title
        return cell
    }
    
}

// MARK: - ItemViewControllerDelegate

extension ItemsViewController: ItemViewControllerDelegate {
    
    func addItem(_ item: Item) {
        items.append(item)
        dismiss(animated: true, completion: nil)
    }
}

