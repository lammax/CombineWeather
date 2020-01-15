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
        
        //showWeather(city: "Tver")
        setupPublishers()
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
    
    private func setupPublishers() {
        let publisher = NotificationCenter.default.publisher(for: UITextField.textDidChangeNotification, object: self.cityNameTextField)
        
        cancellable = publisher.compactMap {
            ($0.object as! UITextField).text?
                .addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) // San Antonio -> San%20Antonio
        }
        .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
        .flatMap { city in
            self.webservice.fetchWeather(city: city)
                .catch { _ in Empty() }
                .map { ($0, city) }
        }
        .sink {
            self.weatherLabel.text = "City = \($0.1)\nTemp = \($0.0?.temp ?? 0.0) ℃\nHumidity = \($0.0?.humidity ?? 0.0) %"
        }
    }
    


}

