//
//  ReviewsTableViewCell.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/7.
//

import UIKit

class ReviewsTableViewCell: UITableViewCell {

    
    let authorTextLabel = UILabel()
    let timeLabel = UILabel()
    let authorName = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        authorName.font = UIFont.systemFont(ofSize: 16)
        authorName.textColor = .black
        authorName.textAlignment = .left
        authorName.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(authorName)
        
        authorName.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp_top).offset(5)
            make.leading.equalTo(contentView.snp_leading).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        authorTextLabel.font = UIFont.systemFont(ofSize: 16)
        authorTextLabel.numberOfLines = 0
        authorTextLabel.textColor = .black
        authorTextLabel.textAlignment = .left
        authorTextLabel.lineBreakMode = .byWordWrapping
        contentView.addSubview(authorTextLabel)
        
        authorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(authorName.snp_bottom).offset(5)
            make.leading.equalTo(contentView.snp_leading).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(100)
        }
        
        timeLabel.font = UIFont.systemFont(ofSize: 16)
        timeLabel.textColor = .black
        timeLabel.textAlignment = .left
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(timeLabel)
        
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(authorTextLabel.snp_bottom).offset(5)
            make.leading.equalTo(contentView.snp_leading).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(20)
        }
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
