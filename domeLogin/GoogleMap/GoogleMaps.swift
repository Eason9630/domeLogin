//
//  GoogleMaps.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/6.
//

import Foundation
import UIKit

class GoogleMap {
    
    static let apiKey = "AIzaSyDUsvvw1-4Liict7_IA_cDFPEYrl77QajU"
    
    static let shared = GoogleMap()
    
    func getMap (location: String,completion: @escaping (Result<[MapInfo], Error>) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=\(location)&radius=1000&type=restaurant&language=zh-TW&key=\(GoogleMap.apiKey)"

        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data , response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MapModel.self, from: data)
                    completion(.success(result.results))
                } catch  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func sreachMap (keyword:String,completion: @escaping (Result<[MapInfo], Error>) -> Void ) {
        let urlString  = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=25.0338,121.5646&radius=1000&keyword=\(keyword)&language=zh-TW&key=\(GoogleMap.apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data , response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MapModel.self, from: data)
                    completion(.success(result.results))
                } catch  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func detailMap (place_id :String , completion:@escaping (Result<DetailInfo ,Error>) -> Void) {
        let urlString = "https://maps.googleapis.com/maps/api/place/details/json?place_id=\(place_id)&key=\(GoogleMap.apiKey)"
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data , response, error in
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(Detail.self, from: data)
                    print(results)
                    completion(.success(results.result))
                } catch  {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
    
    func getPhoto (photo_reference:String ,completion: @escaping (UIImage?) -> Void ) {
        let urlString = "https://maps.googleapis.com/maps/api/place/photo?photo_reference=\(photo_reference)&key=\(GoogleMap.apiKey)&maxwidth=1600"
        
        
        guard let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { data , response, error in
            if let data = data {
                do {
                    let result = UIImage(data: data)
                    print(result)
                    completion(result)
                } catch  {
                    completion(UIImage(systemName: "photo"))
                }
            }
        }.resume()
    }
}
