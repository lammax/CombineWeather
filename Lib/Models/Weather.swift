//
//  Weather.swift
//  CombineWeather
//
//  Created by Mac on 07.01.2020.
//  Copyright © 2020 Lammax. All rights reserved.
//

import Foundation

/*
 JSON
 Example of API response:

 {
   "coord": {
     "lon": -122.08,
     "lat": 37.39
   },
   "weather": [
     {
       "id": 800,
       "main": "Clear",
       "description": "clear sky",
       "icon": "01d"
     }
   ],
   "base": "stations",
   "main": {
     "temp": 282.55,
     "feels_like": 281.86,
     "temp_min": 280.37,
     "temp_max": 284.26,
     "pressure": 1023,
     "humidity": 100
   },
   "visibility": 16093,
   "wind": {
     "speed": 1.5,
     "deg": 350
   },
   "clouds": {
     "all": 1
   },
   "dt": 1560350645,
   "sys": {
     "type": 1,
     "id": 5122,
     "message": 0.0139,
     "country": "US",
     "sunrise": 1560343627,
     "sunset": 1560396563
   },
   "timezone": -25200,
   "id": 420006353,
   "name": "Mountain View",
   "cod": 200
 }
 
 Parameters:
 coord
    coord.lon City geo location, longitude
    coord.lat City geo location, latitude
 weather (more info Weather condition codes)
    weather.id Weather condition id
    weather.main Group of weather parameters (Rain, Snow, Extreme etc.)
    weather.description Weather condition within the group. You can get the output in your language. Learn more
    weather.icon Weather icon id
 base Internal parameter
 main
    main.temp Temperature. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    main.feels_like Temperature. This temperature parameter accounts for the human perception of weather. Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    main.pressure Atmospheric pressure (on the sea level, if there is no sea_level or grnd_level data), hPa
    main.humidity Humidity, %
    main.temp_min Minimum temperature at the moment. This is minimal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    main.temp_max Maximum temperature at the moment. This is maximal currently observed temperature (within large megalopolises and urban areas). Unit Default: Kelvin, Metric: Celsius, Imperial: Fahrenheit.
    main.sea_level Atmospheric pressure on the sea level, hPa
    main.grnd_level Atmospheric pressure on the ground level, hPa
 wind
    wind.speed Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    wind.deg Wind direction, degrees (meteorological)
 clouds
    clouds.all Cloudiness, %
 rain
    rain.1h Rain volume for the last 1 hour, mm
    rain.3h Rain volume for the last 3 hours, mm
 snow
    snow.1h Snow volume for the last 1 hour, mm
    snow.3h Snow volume for the last 3 hours, mm
 dt Time of data calculation, unix, UTC
 sys
    sys.type Internal parameter
    sys.id Internal parameter
    sys.message Internal parameter
    sys.country Country code (GB, JP etc.)
    sys.sunrise Sunrise time, unix, UTC
    sys.sunset Sunset time, unix, UTC
 timezone Shift in seconds from UTC
 id City ID
 name City name
 cod Internal parameter
 */



struct WeatherResponse: Decodable {
    let coord: Coord?
    let main: MainWeather?
    
}

{
    "coord":{
        "lon":35.89,
        "lat":56.86
    },
    "weather":[
        {
            "id":803,
            "main":"Clouds",
            "description":"broken clouds",
            "icon":"04d" // http://openweathermap.org/img/wn/04d@2x.png
        }
    ],
    "base":"stations",
    "main":{
        "temp":12.1,
        "feels_like":7.11,
        "temp_min":12.1,
        "temp_max":12.1,
        "pressure":1009,
        "humidity":48,
        "sea_level":1009,
        "grnd_level":994
    },
    "wind":{
        "speed":4.6,
        "deg":309
        
    },
    "clouds":{
        "all":51
    },
    "dt":1589884211,
    "sys":{
        "country":"RU",
        "sunrise":1589850659,
        "sunset":1589910908
        
    },
    "timezone":10800,
    "id":480060,
    "name":"Tver'",
    "cod":200
}

/*
"coord": {
  "lon": -122.08,
  "lat": 37.39
}
 */
struct Coord {
    let lon: Double
    let lat: Double
}


struct MainWeather: Decodable {
    
    let temp: Double?
    let humidity: Double?
    
    static var placeholder: MainWeather {
        return MainWeather(temp: nil, humidity: nil)
    }
    
    var info: [String] {
        let od2s: (Double?) -> String = { ($0 == nil) ? "" : "\($0!)" }
        let temp: String = "Temp = \([self.temp].map(od2s)[0]) ℃"
        let humidity: String = "Humidity = \([self.humidity].map(od2s)[0]) %"
        
        return [temp, humidity]
    }
    
}
