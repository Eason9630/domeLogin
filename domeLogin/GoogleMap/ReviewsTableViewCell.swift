//
//  ReviewsTableViewCell.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/7.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    @IBOutlet weak var authorTextLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!

    @IBOutlet weak var authorName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
