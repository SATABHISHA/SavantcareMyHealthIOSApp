//
//  PastAppointmentTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 16/03/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class PastAppointmentTableViewCell: UITableViewCell {

   
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    @IBOutlet weak var doctor_image: UIImageView!
    
    @IBOutlet weak var status: UILabel!
    /*  @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var past_appointment_doctor_name: UILabel!
    @IBOutlet weak var pastappointment_image: UIImageView!
    
    @IBOutlet weak var past_appointment_date: UILabel!
    
    @IBOutlet weak var pasr_appointment_time: UILabel!*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
