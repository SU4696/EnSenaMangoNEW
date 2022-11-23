//
//  LearnTableViewCell.swift
//  EnSena
//
//  Created by 조수연 on 2022/11/22.
//

import UIKit

class LearnTableViewCell: UITableViewCell {

    @IBOutlet weak var catView: UIView!
    @IBOutlet weak var catName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
