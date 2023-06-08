//
//  GoogleMapModel.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/5.
//

import Foundation

struct MapModel:Codable {
    let results: [MapInfo]
}
struct MapInfo:Codable {
    let name: String
    let photos:[Photo]
    let place_id:String
    let vicinity: String
    
}
struct Photo:Codable {
    let photo_reference:String
}


// -------------評論資訊-------------------

struct Detail:Codable {
    let result: DetailInfo
}

struct DetailInfo :Codable{
    var name: String                //餐廳名稱
    var photos: [Photo]             //照片
    var reviews: [Reviews]          //評論
}


struct Reviews:Codable {
    var author_name: String
    var profile_photo_url: URL
    var text: String
    var time: Date
}
