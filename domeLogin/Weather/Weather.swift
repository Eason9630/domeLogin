//
//  Weather.swift
//  domeLogin
//
//  Created by 林祔利 on 2023/6/2.
//

import Foundation

struct WeatherModel: Codable {
    let coord: Coord
    let weather: [Weather]
    let main: Main
    let name: String
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}

struct Main: Codable {
    let temp: Double
    let feels_like: Double
    let temp_min: Double
    let temp_max: Double
    let humidity: Int
}
