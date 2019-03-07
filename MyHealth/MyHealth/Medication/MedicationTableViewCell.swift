//
//  MedicationTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 12/07/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

class MedicationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var labelMedicineName: UILabel!
    @IBOutlet weak var labelQuantityRefilSupply: UILabel!
    @IBOutlet weak var labelPharmacist: UILabel!
    @IBOutlet weak var labelPatient: UILabel!
    @IBOutlet weak var labelPrescribedBy: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
