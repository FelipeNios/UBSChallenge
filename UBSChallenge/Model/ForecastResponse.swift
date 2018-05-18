//
//  ForecastResponse.swift
//  UBSChallenge
//
//  Created by Felipe Nunez on 5/18/18.
//  Copyright © 2018 FelipeNunez. All rights reserved.
//

import Foundation

struct ForecastDataSource {
    let date: String
    let list: [ForecastItem]
}

struct ForecastResponse: Codable {
    let cod: String
    let list: [ForecastItem]
    let city: City
}

struct City: Codable {
    let id: Int
    let name: String
    let country: String
    
    init() {
        id = 0
        name = ""
        country = ""
    }
}

struct ForecastItem: Codable {
    let dt: Double
    var datetime: Date {
        return Date(timeIntervalSince1970: dt)
    }
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
}

struct Clouds: Codable {
    let all: Int
}

struct MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
    let icon: String
}
