//
//  HelpdeskHomeTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 04/05/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class HelpdeskHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var ticket_id: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
