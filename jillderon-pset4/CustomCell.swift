//
//  CustomCell.swift
//  jillderon-pset4
//
//  Created by Jill de Ron on 20-11-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var check: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
