//
//  ScreeningTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 22/02/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class ScreeningTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    
    
    @IBOutlet weak var label_screening_name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
