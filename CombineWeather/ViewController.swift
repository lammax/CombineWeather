//
//  ViewController.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import UIKit
import  Combine

class ViewController: UIViewController {
    
    private let webservice = Webservice.sharedInstance
    
    private var cancellable: AnyCancellable?

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        showWeather(city: "Tver")
    }
    
    private func showWeather(city: String) {
        
        cancellable = self.webservice.fetchWeather(city: city)
            .catch { _ in Just(Weather.placeholder) }
        .print()
            .map { weather -> String in
                if let temp = weather?.temp {
                    return "City = \(city)\nTemp = \(temp) ℃\nHumidity = \(weather?.humidity ?? 0.0) %"
                } else {
                    return "Error in getting weather"
                }
            }
        .assign(to: \.text, on: self.weatherLabel)
        
    }
    


}

