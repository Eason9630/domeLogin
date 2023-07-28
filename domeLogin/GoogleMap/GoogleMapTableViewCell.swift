//
//  GoogleMapTableViewCell.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/6.
//

import UIKit
import SnapKit

class GoogleMapTableViewCell: UITableViewCell {

    
    let iconImage = UIImageView()
    let nameLabel = UILabel()
    let DetailLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        nameLabel.textAlignment = .left
        nameLabel.numberOfLines = 0 // 設定為 0 表示允許多行文字
        nameLabel.lineBreakMode = .byWordWrapping // 根據單詞換行
        nameLabel.font = UIFont.systemFont(ofSize: 18)
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.leading.equalTo(contentView.snp_leading).offset(10)
            make.width.equalTo(160)
            make.height.equalTo(30)
        }
        
      
        DetailLabel.textAlignment = .left
        DetailLabel.font = UIFont.systemFont(ofSize: 18)
        DetailLabel.numberOfLines = 0
        DetailLabel.lineBreakMode = .byWordWrapping
        DetailLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(DetailLabel)
        
        DetailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp_bottom).offset(20)
            make.leading.equalTo(contentView.snp_leading).offset(10)
            make.width.equalTo(160)
            make.height.equalTo(60)
        }
        
        
        iconImage.contentMode = .scaleAspectFit
        iconImage.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconImage)
        
        iconImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp_top).offset(10)
            make.trailing.equalTo(contentView.snp_trailing).inset(5)
            make.width.equalTo(120)
            make.height.equalTo(120)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
