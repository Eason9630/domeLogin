//
//  GetWeather.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/3.
//

import Foundation

class GetWeather {
    
    static let apiKey = "4072d5043f1348fc21c6e9316302a015"
    static let share = GetWeather()
    
    func WeatherInfo (lon:String ,lat: String,completion: @escaping(Result<WeatherModel,Error>) -> Void){

        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(GetWeather.apiKey)&lang=zh_tw&units=metric"
        
        guard let url = URL(string: urlString) else {return}

        URLSession.shared.dataTask(with: url) { data , response, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(WeatherModel.self, from: data)
                    print(result)
                    completion(.success(result))
                }catch{
                    completion(.failure(error))
                }
            }
        }.resume()
        
    }

}
