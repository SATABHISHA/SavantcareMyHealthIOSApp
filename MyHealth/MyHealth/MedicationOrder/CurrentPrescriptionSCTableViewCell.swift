//
//  CurrentPrescriptionSCTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 19/09/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class CurrentPrescriptionSCTableViewCell: UITableViewCell {

    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var labelDrugName: UILabel!
    @IBOutlet weak var labelQuantity: UILabel!
    @IBOutlet weak var labelRefill: UILabel!
    @IBOutlet weak var labelDaysSupply: UILabel!
     @IBOutlet weak var labelDirectionToPatient: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
