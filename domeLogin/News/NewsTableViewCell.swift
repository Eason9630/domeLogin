//
//  NewsTableViewCell.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/1.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    
    let InnerLabel: UILabel = {
           let InnerLabel = UILabel()
            InnerLabel.translatesAutoresizingMaskIntoConstraints = false
            InnerLabel.textAlignment = .left
            InnerLabel.numberOfLines = 0 // 設定為 0 表示允許多行文字
            InnerLabel.lineBreakMode = .byWordWrapping // 根據單詞換行
           return InnerLabel
       }()

       let NewsImage: UIImageView = {
           let NewsImage = UIImageView()
           NewsImage.translatesAutoresizingMaskIntoConstraints = false
           NewsImage.contentMode = .scaleAspectFit
           return NewsImage
       }()

       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)

           // Add the customLabel and customImageView to the cell's contentView
           contentView.addSubview(InnerLabel)
           contentView.addSubview(NewsImage)

           // Set AutoLayout constraints for customLabel
           NSLayoutConstraint.activate([
            InnerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            InnerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            InnerLabel.widthAnchor.constraint(equalToConstant: 200),
            InnerLabel.heightAnchor.constraint(equalToConstant: 80)
           ])

           // Set AutoLayout constraints for customImageView
           NSLayoutConstraint.activate([
            NewsImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            NewsImage.leadingAnchor.constraint(equalTo: InnerLabel.trailingAnchor, constant: 50),
            NewsImage.heightAnchor.constraint(equalToConstant: 100),
            NewsImage.widthAnchor.constraint(equalToConstant: 100)
           ])
       }

       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
}
