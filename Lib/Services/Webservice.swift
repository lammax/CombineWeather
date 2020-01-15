//
//  Webservice.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import Combine

class Webservice {
    
    static let sharedInstance = Webservice()
    
    func fetchWeather(city: String) -> AnyPublisher<Weather?, Error> {
        
        guard let url = URL(string: Constants.URLs(city: city, unit: .metric).weather) else { fatalError("Invalid weather URL!") }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { $0.main }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
}
