//
//  Constants.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

struct Constants {
    
    enum Units: String {
        case metric
        case imperial
    }
    
    struct URLs {
        private let weatherAPI: String = "b940b7c880132d7727c8f9d105ee530f"
        private let baseURL: String = "http://api.openweathermap.org/data/2.5/weather?"
        var weather: String = ""
        
        init(city: String, unit: Units) {
            weather += baseURL
            weather += "q=\(city)"
            weather += "&appid=\(weatherAPI)"
            weather += "&units=\(unit.rawValue)"
        }
    }
    
}
