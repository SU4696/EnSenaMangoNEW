//
//  HomeLabelTableViewCell.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/28.
//

import UIKit

class HomeLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var wordView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
