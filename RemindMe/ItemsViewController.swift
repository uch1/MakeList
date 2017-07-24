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
    
    // MARK: - UIViewController lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        items = Item.fetchItems()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        itemsTableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Storyboard Segues
    
    private struct StoryboardSegue {
        static let segueToAddItem = "segueToAddItem"
        static let segueToEditItem = "segueToEditItem"
    }
    
    
    
    // MARK: - Actions
    @IBAction func addNewItem(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: StoryboardSegue.segueToAddItem, sender: nil)
    }
    
    func setCompletedButtonTitle(for item: Item, cell: ItemTableViewCell) {
        //item.isCompleted ? cell.tapCompletedButton.setTitle("Completed", for: .normal) : cell.tapCompletedButton.setTitle("Not Completed", for: .normal)
        if item.isCompleted {
            cell.completedButton.setTitle("Completed", for: .normal)
        } else {
            cell.completedButton.setTitle("Not Completed", for: .normal)
        }
    }
    
    // MARK: - Navigation 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueToAddItem" {
            if let destination = segue.destination as? UINavigationController, let itemVC = destination.visibleViewController as? ItemViewController {
                itemVC.delegate = self
                            }
        } else if segue.identifier == "segueToEditItem" {
            if let indexPath = itemsTableView.indexPathForSelectedRow {
                let item = items[indexPath.row]
                if let destination = segue.destination as? ItemViewController {
                    destination.item = item
                }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "itemCellIdentifier", for: indexPath) as! ItemTableViewCell
        let item = items[indexPath.row]
        //cell.textLabel?.text = item.title
        cell.titleLabel.text = item.title
        cell.dateTitle.text = item.startDate?.convertToString()
        
        setCompletedButtonTitle(for: item, cell: cell)
        
        cell.tapAction = { [weak self] (cell) in
            item.isCompleted = !item.isCompleted
            Item.saveItem()
            
            self?.setCompletedButtonTitle(for: item, cell: cell as! ItemTableViewCell)
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let item = items[indexPath.row]
            Item.delete(item: item)
            items = Item.fetchItems()
        }
    }
    
}

// MARK: - UITableViewDelegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - ItemViewControllerDelegate

extension ItemsViewController: ItemViewControllerDelegate {
    
    func addItem(_ item: Item) {
        items.append(item)
        dismiss(animated: true, completion: nil)
    }
}

