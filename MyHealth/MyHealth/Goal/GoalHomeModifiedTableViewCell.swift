//
//  GoalHomeModifiedTableViewCell.swift
//  MyHealth
//
//  Created by Satabhisha on 04/09/18.
//  Copyright © 2018 grmtech. All rights reserved.
//

import UIKit

protocol GoalHomeModifiedTableViewCellDelegate : class {
    func GoalHomeModifiedTableViewCellDidTapRateGoal(_ sender: GoalHomeModifiedTableViewCell)
    func GoalHomeModifiedTableViewCellDidTapSeeGraph(_ sender: GoalHomeModifiedTableViewCell)
}
class GoalHomeModifiedTableViewCell: UITableViewCell {

    @IBOutlet weak var view_goal: UIView!
    @IBOutlet weak var label_goal: UILabel!
    @IBOutlet weak var label_date: UILabel!
    @IBOutlet weak var label_value_of_rating: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    weak var delegate: GoalHomeModifiedTableViewCellDelegate?
    
    @IBAction func btnRate(_ sender: UIButton) {
        delegate?.GoalHomeModifiedTableViewCellDidTapRateGoal(self)
    }
    
    @IBAction func btnGraph(_ sender: UIButton) {
        delegate?.GoalHomeModifiedTableViewCellDidTapSeeGraph(self)
    }
}
