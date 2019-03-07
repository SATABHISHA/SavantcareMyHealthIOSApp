//
//  UpcomingAppointmentTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 16/03/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class UpcomingAppointmentTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    @IBOutlet weak var upcoming_appointments_doctor_image: UIImageView!
    @IBOutlet weak var upcoming_appointments_hostname: UILabel!
    
    @IBOutlet weak var upcoming_appointments_date: UILabel!
    @IBOutlet weak var upcoming_appointments_time: UILabel!
    @IBOutlet weak var upcoming_appointments_status: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
