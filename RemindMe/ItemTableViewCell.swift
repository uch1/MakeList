//
//  ItemTableViewCell.swift
//  RemindMe
//
//  Created by Uchenna  on 7/24/17.
//  Copyright © 2017 Uchenna Aguocha. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateTitle: UILabel!
    @IBOutlet weak var completedButton: UIButton!
    var tapAction: ((UITableViewCell) -> Void)?
    
    // MARK: - Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        completedButton.layer.cornerRadius = 5
        completedButton.layer.borderWidth = 1
        completedButton.layer.borderColor = UIColor.defaultBlue.cgColor
    }
    
    
    @IBAction func tapCompletedButton(_ sender: UIButton) {
        tapAction?(self)
    }
    
}
















