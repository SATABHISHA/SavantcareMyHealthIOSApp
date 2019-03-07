//
//  HelpdeskViewCommentsTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 14/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class HelpdeskViewCommentsTableViewCell: UITableViewCell {

    @IBOutlet weak var view_comments: UIView!
    @IBOutlet weak var label_comments: UILabel!
    @IBOutlet weak var label_date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
