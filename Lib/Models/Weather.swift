//
//  Weather.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

struct WeatherResponse: Decodable {
    
    let main: Weather?
    
}

struct Weather: Decodable {
    
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: Weather {
        return Weather(temp: nil, humidity: nil)
    }
    
    var info: [String] {
        let od2s: (Double?) -> String = { ($0 == nil) ? "" : "\($0!)" }
        let temp: String = "Temp = \([self.temp].map(od2s)[0]) ℃"
        let humidity: String = "Humidity = \([self.humidity].map(od2s)[0]) %"
        
        return [temp, humidity]
    }
    
}
