//
//  Webservice.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation
import Combine
import UIKit

class Webservice {
    
    static let sharedInstance = Webservice()
    
    func fetchWeather(city: Constants.City) -> AnyPublisher<WeatherResponse?, Error> {
        
        guard let url = URL(string: Constants.URLs(city: city).weather) else { fatalError("Invalid weather URL!") }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: WeatherResponse.self, decoder: JSONDecoder())
            .map { $0 }
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
        
    }
    
    func fetchWeatherIcon(iconID: String?) -> AnyPublisher<UIImage?, Never> {
        
        guard let id = iconID, let url = URL(string: Constants.URLs.init(iconID: id).icon ) else { return Just(nil).eraseToAnyPublisher() }

        return URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .catch { _ in Just(nil) }
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    
    }
    
}
