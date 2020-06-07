//
//  Constants.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

struct Constants {
    
    enum City: String, CaseIterable {
        case tver = "Тверь"
        case abakan = "Абакан"
        case moscow = "Москва"
        case sukko = "Сукко"
        case anapa = "Анапа"
        case ekaterinburg = "Екатеринбург"

        static func list() -> [String] {
            return City.allCases.map { $0.rawValue}
        }
        static func item(by id: Int) -> City {
            return City.allCases[id]
        }
    }
    
    enum Units: String {
        case metric
        case imperial
    }
    
    enum Lang: String {
        case ru
        case us
    }
    
    enum FormFactor: String {
        case currentWeather = "weather"
        case forecast
        //http://api.openweathermap.org/data/2.5/forecast?q=Abakan&units=metric&lang=ru&appid=b940b7c880132d7727c8f9d105ee530f
    }
    
    enum IconType: String {
        case png
        case jpg
        case bmp
        case gif
        case tiff
    }

    struct URLs {
        private let weatherAPI: String = "b940b7c880132d7727c8f9d105ee530f"
        private let baseURL: String = "http://api.openweathermap.org/data/2.5/"

        var weather: String = ""
        var icon: String = ""
        
        init(city: City = .tver, formFactor: FormFactor = .currentWeather, unit: Units = .metric, lang: Lang = .ru) {
            weather += baseURL
            weather += formFactor.rawValue + "?"
            weather += "q=\(city)"
            weather += "&appid=\(weatherAPI)"
            weather += "&units=\(unit.rawValue)"
            weather += "&lang=\(lang.rawValue)"
            //print(weather)
        }
        
        private let baseIconURL: String = "http://openweathermap.org/img/wn/"

        init(iconID: String, type: IconType = .png) {
            icon += baseIconURL
            icon += iconID
            icon += "@2x."
            icon += type.rawValue
            //print(icon)
        }
        
    }
    
}
