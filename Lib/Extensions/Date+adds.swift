//
//  Date+adds.swift
//  CombineWeather
//
//  Created by Mac on 30.05.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

extension Date {
    
    var unixTimestamp: TimeInterval {
        return self.timeIntervalSince1970 * 1_000
    }

    static func from(unix time: Double?, gmt shift: Int?) -> String {
        if let unixTime = time, let gmtShift = shift {
            let date = Date(timeIntervalSince1970: unixTime)
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
            dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
            dateFormatter.dateFormat = "HH:mm"
            dateFormatter.timeZone = TimeZone(secondsFromGMT: gmtShift)
            return dateFormatter.string(from: date)
        }
        
        return ""
    }
    
}
