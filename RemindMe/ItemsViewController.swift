//
//  ItemsViewController.swift
//  RemindMe
//
//  Created by Uchenna  on 7/17/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit

class ItemsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var itemsTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemCellIdentifier", for: indexPath)
        cell.textLabel?.text = "test"
        return cell
    }
}

