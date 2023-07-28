//
//  NewsModel.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/1.
//

import Foundation

struct News:Codable {
    let status: String
    let articles: [Articles]
    
}

struct Articles:Codable {
    let title: String
    let description: String?
    let url: String
    let urlToImage: URL?
}
