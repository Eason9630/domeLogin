//
//  NewsTableViewCell.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/1.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var InnerLabel: UILabel!
    @IBOutlet weak var NewsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
