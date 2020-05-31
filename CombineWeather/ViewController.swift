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
    
    private let notificationCenter = NotificationCenter.default

    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var sunriseLabel: UILabel!
    @IBOutlet weak var sunsetLabel: UILabel!
    
    private let cityPicker = UIPickerView()
    private var citiesList: [String] = []
    private var currentCity: Constants.City = .tver
    private var waitForWeatherData: String {
        "Waiting for \(currentCity.rawValue) weather..."
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //showWeather(city: "Tver")
        setupPublishers()
        setupUI()
        setupData()
        //setupPickerToolBar()
    }
    
    private func setupUI() {
        
        setupPicker()
        setupPickerToolBar()
//        cityNameTextField.becomeFirstResponder()

    }
    
    private func setupPicker() {
        cityPicker.delegate = self
        cityPicker.dataSource = self
        cityNameTextField.delegate = self
        cityNameTextField.inputView = cityPicker
    }
    
    private func setupData() {
        citiesList = Constants.City.list()
        self.weatherLabel.text = waitForWeatherData
        self.cityNameTextField.text = "City: " + (citiesList.first ?? "")
        notificationCenter.post(name: UITextField.textDidEndEditingNotification, object: self.cityNameTextField)
    }
    
    private func setupPickerToolBar() {
        //TODO
        let toolBar = UIToolbar()
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(self.donePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelPicker))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        cityNameTextField.inputAccessoryView = toolBar
    }
    
    @objc func donePicker() {
        cityNameTextField.resignFirstResponder()
    }
    @objc func cancelPicker() {
        cityNameTextField.resignFirstResponder()
    }

    private func showWeather(city: Constants.City) {
        
        cancellable = self.webservice.fetchWeather(city: city)
            .catch { _ in Just(WeatherResponse.placeholder) }
        .print()
            .map { weather -> String in
                if let temp = weather?.main?.temp {
                    //let city ="City = \(city)\n"
                    return "Temp = \(temp) ℃\nHumidity = \(weather?.main?.humidity ?? 0.0) %"
                } else {
                    return "Error in getting weather"
                }
            }
            .assign(to: \.text, on: self.weatherLabel)
        
    }
    
    private func setupPublishers() {
        let publisher = notificationCenter.publisher(for: UITextField.textDidEndEditingNotification, object: self.cityNameTextField)
        
        cancellable = publisher.compactMap { obj in
            (obj.object as! UITextField).text
        }
        .debounce(for: .seconds(1.0), scheduler: RunLoop.main)
        .flatMap { _ in
            self.webservice.fetchWeather(city: self.currentCity)
                .catch { error in Just(WeatherResponse.placeholder) }
                .map { ($0, self.currentCity)
            }
        }
        .sink {
            //let city = "City = \($0.0?.name ?? $0.1.rawValue)"
            let info: [String] = ($0.0?.main?.info ?? [])
            self.weatherLabel.text = info.joined(separator: "\n")
            
            let _ = self.webservice.fetchWeatherIcon(iconID: $0.0?.weather?.first?.icon)
            .catch { r_ in Just(nil) }
            .map { $0 }
            .sink { self.weatherIcon.image = $0 }
            
            //Sunrise & sunset
            self.sunriseLabel.text = Date.from(unix: $0.0?.sys?.sunrise, gmt: $0.0?.timezone)
            self.sunsetLabel.text = Date.from(unix: $0.0?.sys?.sunset, gmt: $0.0?.timezone)

        }
    }
    


}

extension ViewController: UITextFieldDelegate {
}

extension ViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        citiesList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currentCity = Constants.City.item(by: row)
        self.cityNameTextField.text = "City: " + citiesList[row]
        self.weatherLabel.text = waitForWeatherData
        notificationCenter.post(name: UITextField.textDidEndEditingNotification, object: self.cityNameTextField)
    }
    
}

extension ViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        citiesList.count
    }
}
