//
//  Date+adds.swift
//  CombineWeather
//
//  Created by Mac on 30.05.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

extension Date {
    
    static func from(unix time: Double?) -> String {
        if let unixTime = time {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = .current
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
}
