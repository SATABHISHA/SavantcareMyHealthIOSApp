//
//  MoodTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 26/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class MoodTableViewCell: UITableViewCell {

    @IBOutlet weak var labelDay: UILabel!
    @IBOutlet weak var labelDayName: UILabel!
    @IBOutlet weak var labelTime: UILabel!
    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var imageMood: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
