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
 
 //Tver
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
             "icon":"04d"
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
 visibility
     visibility.value Visibility, meter
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



struct CurrentWeather: Decodable {
    let coord: Coord?
    let weather: [Weather]?
    let main: MainWeather?
    let wind: Wind?
    let clouds: Clouds?
    let sys: Sys?
    let base: String? // Internal parameter
    let visibility: Int? //meters
    let dt: UInt? //Time of data calculation, unix, UTC
    let timezone: Int? //Shift in seconds from UTC
    let id: Int? //City ID
    let name: String? //City name
    let cod: Int? //Internal parameter
    
    init(coord: Coord? = nil,
         weather: [Weather]? = nil,
         main: MainWeather? = nil,
         wind: Wind? = nil,
         clouds: Clouds? = nil,
         sys: Sys? = nil,
         base: String? = nil,
         visibility: Int? = nil,
         dt: UInt? = nil,
         timezone: Int? = nil,
         id: Int? = nil,
         name: String? = nil,
         cod: Int? = nil) {
        
        self.coord = coord
        self.weather = weather
        self.main = main
        self.wind = wind
        self.clouds = clouds
        self.sys = sys
        self.base = base
        self.visibility = visibility
        self.dt = dt
        self.timezone = timezone
        self.id = id
        self.name = name
        self.cod = cod
    }
    
    static var placeholder: CurrentWeather {
        return CurrentWeather(
            coord: nil,
            weather: nil,
            main: nil,
            wind: nil,
            clouds: nil,
            sys: nil,
            base: nil,
            visibility: nil,
            dt: nil,
            timezone: nil,
            id: nil,
            name: nil,
            cod: nil
        )
    }
}

struct ForecastWeather: Decodable {
    let cod: String?
    let message: Int?
    let cnt: Int? //Number of lines returned by this API call
    let list: [ForecastData]?
    let city: City?
    
    init(cod: String? = nil, message: Int? = nil, cnt: Int? = nil, list: [ForecastData]? = nil, city: City? = nil) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
    
    static var placeholder: ForecastWeather {
        return ForecastWeather(
            cod: nil,
            message: nil,
            cnt: nil,
            list: nil,
            city: nil
        )
    }
}

struct Coord: Decodable {
    let lon: Double?
    let lat: Double?
}

struct MainWeather: Decodable {
    
    let temp: Double?
    let feels_like: Double?
    let temp_min: Double?
    let temp_max: Double?
    let pressure: Double? //Atmospheric pressure on the sea level by default, hPa
    let humidity: Double?
    let sea_level: Int? //Atmospheric pressure on the sea level, hPa
    let grnd_level: Int? //Atmospheric pressure on the ground level, hPa
    let temp_kf: Double? //Internal parameter

    static var placeholder: MainWeather {
        return MainWeather(
            temp: nil,
            feels_like: nil,
            temp_min: nil,
            temp_max: nil,
            pressure: nil,
            humidity: nil,
            sea_level: nil,
            grnd_level: nil,
            temp_kf: nil
        )
    }
    
    var info: [String] {
        let od2s: (Double?) -> String = { ($0 == nil) ? "" : "\($0!)" }
        let temp: String = "Temp = \(od2s(self.temp)) ℃"
        let humidity: String = "Humidity = \([self.humidity].map(od2s)[0]) %"
        
        return [temp, humidity]
    }
    
}

struct Weather: Decodable {
    let id: Int? //Weather condition id
    let main: String? //Group of weather parameters (Rain, Snow, Extreme etc.)
    let description: String? //Weather condition within the group. You can get the output in your language. Learn more
    let icon: String? //Weather icon <id>: http://openweathermap.org/img/wn/<id>@2x.png
    
    var info: [String] {
        let description: String = self.description ?? ""
        return [description]
    }
}

struct Wind: Decodable {
    let speed: Double? //Wind speed. Unit Default: meter/sec, Metric: meter/sec, Imperial: miles/hour.
    let deg: Int? //Wind direction, degrees (meteorological) - from where wind blowing
}

struct Clouds: Decodable {
    let all: Int? // Cloudiness, %
}

struct Sys: Decodable {
    let type: Int? //Internal parameter
    let id: Int? //Internal parameter
    let message: Double? //Internal parameter
    let country: String? //Country code (GB, JP etc.)
    let sunrise: Double? //Sunrise time, unix, UTC
    let sunset: Double? //Sunset time, unix, UTC
    let pod: String? //Internal parameter
}

struct City: Decodable {
    let id: Int?
    let name: String?
    let coord: Coord?
    let country: String? //Country code (GB, JP etc.)
    let population: UInt? //people num
    let timezone: Int?
    let sunrise: Double? //Sunrise time, unix, UTC
    let sunset: Double? //Sunset time, unix, UTC
}

struct Rain: Decodable {
    let oneHour: Double? //Rain volume for the last 1 hour, mm
    let twoHours: Double? //Rain volume for the last 3 hours, mm
    
    enum CodingKeys: String, CodingKey {
       case oneHour = "1h"
       case twoHours = "3h"
    }
}

struct ForecastData: Decodable {
    let dt: UInt? //Time of data forecasted, unix, UTC
    let main: MainWeather?
    let weather: [Weather]?
    let clouds: Clouds?
    let wind: Wind?
    let rain: Rain?
    let sys: Sys?
    let dt_txt: String? //Time of data forecasted, ISO, UTC
}

/*
 //Forecast example
{
  "cod": "200",
  "message": 0,
  "cnt": 40,
  "list": [
    {
      "dt": 1590937200,
      "main": {
        "temp": 15.19,
        "feels_like": 12.31,
        "temp_min": 13.3,
        "temp_max": 15.19,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 66,
        "temp_kf": 1.89
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 69
      },
      "wind": {
        "speed": 3.76,
        "deg": 271
      },
      "rain": {
        "3h": 0.94
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-05-31 15:00:00"
    },
    {
      "dt": 1590948000,
      "main": {
        "temp": 13.72,
        "feels_like": 10.11,
        "temp_min": 12.82,
        "temp_max": 13.72,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 70,
        "temp_kf": 0.9
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 87
      },
      "wind": {
        "speed": 4.61,
        "deg": 284
      },
      "rain": {
        "3h": 0.2
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-05-31 18:00:00"
    },
    {
      "dt": 1590958800,
      "main": {
        "temp": 11.57,
        "feels_like": 9.16,
        "temp_min": 11.2,
        "temp_max": 11.57,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 74,
        "temp_kf": 0.37
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 96
      },
      "wind": {
        "speed": 2.48,
        "deg": 301
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-05-31 21:00:00"
    },
    {
      "dt": 1590969600,
      "main": {
        "temp": 11.38,
        "feels_like": 9.37,
        "temp_min": 11.33,
        "temp_max": 11.38,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 72,
        "temp_kf": 0.05
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 1.72,
        "deg": 252
      },
      "rain": {
        "3h": 0.44
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-01 00:00:00"
    },
    {
      "dt": 1590980400,
      "main": {
        "temp": 11.01,
        "feels_like": 7.51,
        "temp_min": 11.01,
        "temp_max": 11.01,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 82,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 4.36,
        "deg": 211
      },
      "rain": {
        "3h": 1.7
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-01 03:00:00"
    },
    {
      "dt": 1590991200,
      "main": {
        "temp": 12.73,
        "feels_like": 9.21,
        "temp_min": 12.73,
        "temp_max": 12.73,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 74,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 4.44,
        "deg": 199
      },
      "rain": {
        "3h": 2.91
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-01 06:00:00"
    },
    {
      "dt": 1591002000,
      "main": {
        "temp": 12.73,
        "feels_like": 9.66,
        "temp_min": 12.73,
        "temp_max": 12.73,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 75,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 95
      },
      "wind": {
        "speed": 3.86,
        "deg": 204
      },
      "rain": {
        "3h": 0.27
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-01 09:00:00"
    },
    {
      "dt": 1591012800,
      "main": {
        "temp": 14.92,
        "feels_like": 13.94,
        "temp_min": 14.92,
        "temp_max": 14.92,
        "pressure": 1010,
        "sea_level": 1010,
        "grnd_level": 981,
        "humidity": 72,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 94
      },
      "wind": {
        "speed": 1.43,
        "deg": 231
      },
      "rain": {
        "3h": 0.38
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-01 12:00:00"
    },
    {
      "dt": 1591023600,
      "main": {
        "temp": 12.42,
        "feels_like": 10.93,
        "temp_min": 12.42,
        "temp_max": 12.42,
        "pressure": 1012,
        "sea_level": 1012,
        "grnd_level": 982,
        "humidity": 79,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 1.78,
        "deg": 107
      },
      "rain": {
        "3h": 0.21
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-01 15:00:00"
    },
    {
      "dt": 1591034400,
      "main": {
        "temp": 10.25,
        "feels_like": 8.86,
        "temp_min": 10.25,
        "temp_max": 10.25,
        "pressure": 1011,
        "sea_level": 1011,
        "grnd_level": 982,
        "humidity": 87,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 97
      },
      "wind": {
        "speed": 1.38,
        "deg": 132
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-01 18:00:00"
    },
    {
      "dt": 1591045200,
      "main": {
        "temp": 8.92,
        "feels_like": 6.82,
        "temp_min": 8.92,
        "temp_max": 8.92,
        "pressure": 1011,
        "sea_level": 1011,
        "grnd_level": 981,
        "humidity": 87,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "облачно с прояснениями",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 69
      },
      "wind": {
        "speed": 1.96,
        "deg": 97
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-01 21:00:00"
    },
    {
      "dt": 1591056000,
      "main": {
        "temp": 11.04,
        "feels_like": 9.08,
        "temp_min": 11.04,
        "temp_max": 11.04,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 73,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "облачно с прояснениями",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 71
      },
      "wind": {
        "speed": 1.61,
        "deg": 90
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-02 00:00:00"
    },
    {
      "dt": 1591066800,
      "main": {
        "temp": 10.76,
        "feels_like": 7.58,
        "temp_min": 10.76,
        "temp_max": 10.76,
        "pressure": 1006,
        "sea_level": 1006,
        "grnd_level": 976,
        "humidity": 85,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 501,
          "main": "Rain",
          "description": "дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 3.99,
        "deg": 122
      },
      "rain": {
        "3h": 3.7
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-02 03:00:00"
    },
    {
      "dt": 1591077600,
      "main": {
        "temp": 13.05,
        "feels_like": 11,
        "temp_min": 13.05,
        "temp_max": 13.05,
        "pressure": 1005,
        "sea_level": 1005,
        "grnd_level": 976,
        "humidity": 83,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 3.08,
        "deg": 149
      },
      "rain": {
        "3h": 0.95
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-02 06:00:00"
    },
    {
      "dt": 1591088400,
      "main": {
        "temp": 17.19,
        "feels_like": 16.69,
        "temp_min": 17.19,
        "temp_max": 17.19,
        "pressure": 1003,
        "sea_level": 1003,
        "grnd_level": 975,
        "humidity": 77,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 2.1,
        "deg": 185
      },
      "rain": {
        "3h": 0.35
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-02 09:00:00"
    },
    {
      "dt": 1591099200,
      "main": {
        "temp": 18.61,
        "feels_like": 19.17,
        "temp_min": 18.61,
        "temp_max": 18.61,
        "pressure": 1003,
        "sea_level": 1003,
        "grnd_level": 975,
        "humidity": 78,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 94
      },
      "wind": {
        "speed": 1.35,
        "deg": 138
      },
      "rain": {
        "3h": 0.9
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-02 12:00:00"
    },
    {
      "dt": 1591110000,
      "main": {
        "temp": 15.17,
        "feels_like": 12.85,
        "temp_min": 15.17,
        "temp_max": 15.17,
        "pressure": 1004,
        "sea_level": 1004,
        "grnd_level": 976,
        "humidity": 78,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 59
      },
      "wind": {
        "speed": 3.93,
        "deg": 269
      },
      "rain": {
        "3h": 0.65
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-02 15:00:00"
    },
    {
      "dt": 1591120800,
      "main": {
        "temp": 13.24,
        "feels_like": 11.18,
        "temp_min": 13.24,
        "temp_max": 13.24,
        "pressure": 1006,
        "sea_level": 1006,
        "grnd_level": 977,
        "humidity": 84,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "переменная облачность",
          "icon": "03n"
        }
      ],
      "clouds": {
        "all": 33
      },
      "wind": {
        "speed": 3.24,
        "deg": 256
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-02 18:00:00"
    },
    {
      "dt": 1591131600,
      "main": {
        "temp": 12.81,
        "feels_like": 11.74,
        "temp_min": 12.81,
        "temp_max": 12.81,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 85,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "облачно с прояснениями",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 84
      },
      "wind": {
        "speed": 1.73,
        "deg": 242
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-02 21:00:00"
    },
    {
      "dt": 1591142400,
      "main": {
        "temp": 13.81,
        "feels_like": 12.22,
        "temp_min": 13.81,
        "temp_max": 13.81,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 76,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 88
      },
      "wind": {
        "speed": 2.2,
        "deg": 271
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-03 00:00:00"
    },
    {
      "dt": 1591153200,
      "main": {
        "temp": 15.38,
        "feels_like": 11.72,
        "temp_min": 15.38,
        "temp_max": 15.38,
        "pressure": 1010,
        "sea_level": 1010,
        "grnd_level": 981,
        "humidity": 62,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 96
      },
      "wind": {
        "speed": 4.61,
        "deg": 286
      },
      "rain": {
        "3h": 0.23
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-03 03:00:00"
    },
    {
      "dt": 1591164000,
      "main": {
        "temp": 18.18,
        "feels_like": 14.67,
        "temp_min": 18.18,
        "temp_max": 18.18,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 46,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10d"
        }
      ],
      "clouds": {
        "all": 95
      },
      "wind": {
        "speed": 3.82,
        "deg": 291
      },
      "rain": {
        "3h": 0.16
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-03 06:00:00"
    },
    {
      "dt": 1591174800,
      "main": {
        "temp": 18.44,
        "feels_like": 16.49,
        "temp_min": 18.44,
        "temp_max": 18.44,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 980,
        "humidity": 45,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 87
      },
      "wind": {
        "speed": 1.56,
        "deg": 358
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-03 09:00:00"
    },
    {
      "dt": 1591185600,
      "main": {
        "temp": 16.75,
        "feels_like": 14.89,
        "temp_min": 16.75,
        "temp_max": 16.75,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 61,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 93
      },
      "wind": {
        "speed": 2.41,
        "deg": 78
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-03 12:00:00"
    },
    {
      "dt": 1591196400,
      "main": {
        "temp": 12.75,
        "feels_like": 10.27,
        "temp_min": 12.75,
        "temp_max": 12.75,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 78,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 3.23,
        "deg": 356
      },
      "rain": {
        "3h": 1.02
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-03 15:00:00"
    },
    {
      "dt": 1591207200,
      "main": {
        "temp": 10.99,
        "feels_like": 9.16,
        "temp_min": 10.99,
        "temp_max": 10.99,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 83,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 88
      },
      "wind": {
        "speed": 2.02,
        "deg": 332
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-03 18:00:00"
    },
    {
      "dt": 1591218000,
      "main": {
        "temp": 10.79,
        "feels_like": 9.08,
        "temp_min": 10.79,
        "temp_max": 10.79,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 81,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04n"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 1.67,
        "deg": 352
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-03 21:00:00"
    },
    {
      "dt": 1591228800,
      "main": {
        "temp": 10.93,
        "feels_like": 9.16,
        "temp_min": 10.93,
        "temp_max": 10.93,
        "pressure": 1011,
        "sea_level": 1011,
        "grnd_level": 981,
        "humidity": 79,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 804,
          "main": "Clouds",
          "description": "пасмурно",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 100
      },
      "wind": {
        "speed": 1.67,
        "deg": 327
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-04 00:00:00"
    },
    {
      "dt": 1591239600,
      "main": {
        "temp": 14.47,
        "feels_like": 12.55,
        "temp_min": 14.47,
        "temp_max": 14.47,
        "pressure": 1009,
        "sea_level": 1009,
        "grnd_level": 980,
        "humidity": 60,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "облачно с прояснениями",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 63
      },
      "wind": {
        "speed": 1.68,
        "deg": 17
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-04 03:00:00"
    },
    {
      "dt": 1591250400,
      "main": {
        "temp": 17.44,
        "feels_like": 15.41,
        "temp_min": 17.44,
        "temp_max": 17.44,
        "pressure": 1007,
        "sea_level": 1007,
        "grnd_level": 979,
        "humidity": 48,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "переменная облачность",
          "icon": "03d"
        }
      ],
      "clouds": {
        "all": 40
      },
      "wind": {
        "speed": 1.69,
        "deg": 37
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-04 06:00:00"
    },
    {
      "dt": 1591261200,
      "main": {
        "temp": 18.72,
        "feels_like": 16.67,
        "temp_min": 18.72,
        "temp_max": 18.72,
        "pressure": 1006,
        "sea_level": 1006,
        "grnd_level": 978,
        "humidity": 43,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "переменная облачность",
          "icon": "03d"
        }
      ],
      "clouds": {
        "all": 49
      },
      "wind": {
        "speed": 1.58,
        "deg": 91
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-04 09:00:00"
    },
    {
      "dt": 1591272000,
      "main": {
        "temp": 18.28,
        "feels_like": 16.06,
        "temp_min": 18.28,
        "temp_max": 18.28,
        "pressure": 1006,
        "sea_level": 1006,
        "grnd_level": 978,
        "humidity": 46,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "переменная облачность",
          "icon": "03d"
        }
      ],
      "clouds": {
        "all": 39
      },
      "wind": {
        "speed": 2,
        "deg": 129
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-04 12:00:00"
    },
    {
      "dt": 1591282800,
      "main": {
        "temp": 12.36,
        "feels_like": 9.43,
        "temp_min": 12.36,
        "temp_max": 12.36,
        "pressure": 1007,
        "sea_level": 1007,
        "grnd_level": 978,
        "humidity": 73,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 72
      },
      "wind": {
        "speed": 3.41,
        "deg": 31
      },
      "rain": {
        "3h": 0.75
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-04 15:00:00"
    },
    {
      "dt": 1591293600,
      "main": {
        "temp": 9.59,
        "feels_like": 8.16,
        "temp_min": 9.59,
        "temp_max": 9.59,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 979,
        "humidity": 88,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 500,
          "main": "Rain",
          "description": "небольшой дождь",
          "icon": "10n"
        }
      ],
      "clouds": {
        "all": 47
      },
      "wind": {
        "speed": 1.27,
        "deg": 359
      },
      "rain": {
        "3h": 0.95
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-04 18:00:00"
    },
    {
      "dt": 1591304400,
      "main": {
        "temp": 8.81,
        "feels_like": 7.79,
        "temp_min": 8.81,
        "temp_max": 8.81,
        "pressure": 1008,
        "sea_level": 1008,
        "grnd_level": 978,
        "humidity": 88,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 801,
          "main": "Clouds",
          "description": "небольшая облачность",
          "icon": "02n"
        }
      ],
      "clouds": {
        "all": 16
      },
      "wind": {
        "speed": 0.44,
        "deg": 304
      },
      "sys": {
        "pod": "n"
      },
      "dt_txt": "2020-06-04 21:00:00"
    },
    {
      "dt": 1591315200,
      "main": {
        "temp": 11.37,
        "feels_like": 10.34,
        "temp_min": 11.37,
        "temp_max": 11.37,
        "pressure": 1007,
        "sea_level": 1007,
        "grnd_level": 978,
        "humidity": 76,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "ясно",
          "icon": "01d"
        }
      ],
      "clouds": {
        "all": 8
      },
      "wind": {
        "speed": 0.57,
        "deg": 320
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-05 00:00:00"
    },
    {
      "dt": 1591326000,
      "main": {
        "temp": 15.48,
        "feels_like": 14.46,
        "temp_min": 15.48,
        "temp_max": 15.48,
        "pressure": 1005,
        "sea_level": 1005,
        "grnd_level": 976,
        "humidity": 62,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "ясно",
          "icon": "01d"
        }
      ],
      "clouds": {
        "all": 1
      },
      "wind": {
        "speed": 0.87,
        "deg": 205
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-05 03:00:00"
    },
    {
      "dt": 1591336800,
      "main": {
        "temp": 18.35,
        "feels_like": 15.41,
        "temp_min": 18.35,
        "temp_max": 18.35,
        "pressure": 1003,
        "sea_level": 1003,
        "grnd_level": 975,
        "humidity": 44,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 800,
          "main": "Clear",
          "description": "ясно",
          "icon": "01d"
        }
      ],
      "clouds": {
        "all": 3
      },
      "wind": {
        "speed": 2.85,
        "deg": 220
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-05 06:00:00"
    },
    {
      "dt": 1591347600,
      "main": {
        "temp": 19.89,
        "feels_like": 16.74,
        "temp_min": 19.89,
        "temp_max": 19.89,
        "pressure": 1002,
        "sea_level": 1002,
        "grnd_level": 974,
        "humidity": 39,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 802,
          "main": "Clouds",
          "description": "переменная облачность",
          "icon": "03d"
        }
      ],
      "clouds": {
        "all": 34
      },
      "wind": {
        "speed": 3.05,
        "deg": 213
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-05 09:00:00"
    },
    {
      "dt": 1591358400,
      "main": {
        "temp": 17.31,
        "feels_like": 14.69,
        "temp_min": 17.31,
        "temp_max": 17.31,
        "pressure": 1002,
        "sea_level": 1002,
        "grnd_level": 974,
        "humidity": 57,
        "temp_kf": 0
      },
      "weather": [
        {
          "id": 803,
          "main": "Clouds",
          "description": "облачно с прояснениями",
          "icon": "04d"
        }
      ],
      "clouds": {
        "all": 60
      },
      "wind": {
        "speed": 3.32,
        "deg": 340
      },
      "sys": {
        "pod": "d"
      },
      "dt_txt": "2020-06-05 12:00:00"
    }
  ],
  "city": {
    "id": 1512236,
    "name": "Абакан",
    "coord": {
      "lat": 53.7156,
      "lon": 91.4292
    },
    "country": "RU",
    "population": 167289,
    "timezone": 25200,
    "sunrise": 1590874302,
    "sunset": 1590934357
  }
}
*/

/*
{
   "cod":"200",
   "message":0,
   "cnt":40,
   "list":[
      {
         "dt":1590937200,
         "main":{
            "temp":13.29,
            "feels_like":7.4,
            "temp_min":11.64,
            "temp_max":13.29,
            "pressure":1014,
            "sea_level":1014,
            "grnd_level":998,
            "humidity":61,
            "temp_kf":1.65
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":79
         },
         "wind":{
            "speed":7.08,
            "deg":29
         },
         "rain":{
            "3h":0.65
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-05-31 15:00:00"
      },
      {
         "dt":1590948000,
         "main":{
            "temp":9.68,
            "feels_like":5.26,
            "temp_min":8.25,
            "temp_max":9.68,
            "pressure":1015,
            "sea_level":1015,
            "grnd_level":999,
            "humidity":69,
            "temp_kf":1.43
         },
         "weather":[
            {
               "id":803,
               "main":"Clouds",
               "description":"облачно с прояснениями",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":57
         },
         "wind":{
            "speed":4.5,
            "deg":17
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-05-31 18:00:00"
      },
      {
         "dt":1590958800,
         "main":{
            "temp":6.74,
            "feels_like":1.77,
            "temp_min":6.18,
            "temp_max":6.74,
            "pressure":1015,
            "sea_level":1015,
            "grnd_level":999,
            "humidity":77,
            "temp_kf":0.56
         },
         "weather":[
            {
               "id":802,
               "main":"Clouds",
               "description":"переменная облачность",
               "icon":"03n"
            }
         ],
         "clouds":{
            "all":27
         },
         "wind":{
            "speed":4.95,
            "deg":21
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-05-31 21:00:00"
      },
      {
         "dt":1590969600,
         "main":{
            "temp":6.6,
            "feels_like":1.7,
            "temp_min":6.53,
            "temp_max":6.6,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":999,
            "humidity":79,
            "temp_kf":0.07
         },
         "weather":[
            {
               "id":802,
               "main":"Clouds",
               "description":"переменная облачность",
               "icon":"03n"
            }
         ],
         "clouds":{
            "all":36
         },
         "wind":{
            "speed":4.91,
            "deg":16
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-01 00:00:00"
      },
      {
         "dt":1590980400,
         "main":{
            "temp":6.23,
            "feels_like":1.36,
            "temp_min":6.23,
            "temp_max":6.23,
            "pressure":1014,
            "sea_level":1014,
            "grnd_level":998,
            "humidity":92,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.36,
            "deg":18
         },
         "rain":{
            "3h":0.5
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 03:00:00"
      },
      {
         "dt":1590991200,
         "main":{
            "temp":8.67,
            "feels_like":4.27,
            "temp_min":8.67,
            "temp_max":8.67,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":87,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.17,
            "deg":30
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 06:00:00"
      },
      {
         "dt":1591002000,
         "main":{
            "temp":10.1,
            "feels_like":5.09,
            "temp_min":10.1,
            "temp_max":10.1,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":85,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":99
         },
         "wind":{
            "speed":6.39,
            "deg":39
         },
         "rain":{
            "3h":1.09
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 09:00:00"
      },
      {
         "dt":1591012800,
         "main":{
            "temp":11.13,
            "feels_like":7.36,
            "temp_min":11.13,
            "temp_max":11.13,
            "pressure":1017,
            "sea_level":1017,
            "grnd_level":1001,
            "humidity":80,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.66,
            "deg":66
         },
         "rain":{
            "3h":1.05
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 12:00:00"
      },
      {
         "dt":1591023600,
         "main":{
            "temp":12.04,
            "feels_like":8.04,
            "temp_min":12.04,
            "temp_max":12.04,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":76,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.03,
            "deg":60
         },
         "rain":{
            "3h":0.71
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 15:00:00"
      },
      {
         "dt":1591034400,
         "main":{
            "temp":9.89,
            "feels_like":5.98,
            "temp_min":9.89,
            "temp_max":9.89,
            "pressure":1017,
            "sea_level":1017,
            "grnd_level":1001,
            "humidity":82,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":97
         },
         "wind":{
            "speed":4.58,
            "deg":51
         },
         "rain":{
            "3h":0.25
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-01 18:00:00"
      },
      {
         "dt":1591045200,
         "main":{
            "temp":8.2,
            "feels_like":3.69,
            "temp_min":8.2,
            "temp_max":8.2,
            "pressure":1017,
            "sea_level":1017,
            "grnd_level":1000,
            "humidity":82,
            "temp_kf":0
         },
         "weather":[
            {
               "id":803,
               "main":"Clouds",
               "description":"облачно с прояснениями",
               "icon":"04n"
            }
         ],
         "clouds":{
            "all":75
         },
         "wind":{
            "speed":4.92,
            "deg":55
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-01 21:00:00"
      },
      {
         "dt":1591056000,
         "main":{
            "temp":7.3,
            "feels_like":2.39,
            "temp_min":7.3,
            "temp_max":7.3,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":78,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04n"
            }
         ],
         "clouds":{
            "all":88
         },
         "wind":{
            "speed":5.06,
            "deg":58
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-02 00:00:00"
      },
      {
         "dt":1591066800,
         "main":{
            "temp":7.78,
            "feels_like":2.44,
            "temp_min":7.78,
            "temp_max":7.78,
            "pressure":1015,
            "sea_level":1015,
            "grnd_level":999,
            "humidity":77,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":96
         },
         "wind":{
            "speed":5.75,
            "deg":63
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 03:00:00"
      },
      {
         "dt":1591077600,
         "main":{
            "temp":10.87,
            "feels_like":4.93,
            "temp_min":10.87,
            "temp_max":10.87,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":67,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":98
         },
         "wind":{
            "speed":6.87,
            "deg":68
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 06:00:00"
      },
      {
         "dt":1591088400,
         "main":{
            "temp":11.45,
            "feels_like":7.07,
            "temp_min":11.45,
            "temp_max":11.45,
            "pressure":1016,
            "sea_level":1016,
            "grnd_level":1000,
            "humidity":68,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.87,
            "deg":68
         },
         "rain":{
            "3h":0.17
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 09:00:00"
      },
      {
         "dt":1591099200,
         "main":{
            "temp":10.17,
            "feels_like":7.17,
            "temp_min":10.17,
            "temp_max":10.17,
            "pressure":1015,
            "sea_level":1015,
            "grnd_level":999,
            "humidity":88,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":3.72,
            "deg":90
         },
         "rain":{
            "3h":1.19
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 12:00:00"
      },
      {
         "dt":1591110000,
         "main":{
            "temp":9.81,
            "feels_like":6.42,
            "temp_min":9.81,
            "temp_max":9.81,
            "pressure":1014,
            "sea_level":1014,
            "grnd_level":998,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.49,
            "deg":78
         },
         "rain":{
            "3h":2.06
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 15:00:00"
      },
      {
         "dt":1591120800,
         "main":{
            "temp":10.11,
            "feels_like":7.29,
            "temp_min":10.11,
            "temp_max":10.11,
            "pressure":1014,
            "sea_level":1014,
            "grnd_level":998,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":3.79,
            "deg":66
         },
         "rain":{
            "3h":1.7
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-02 18:00:00"
      },
      {
         "dt":1591131600,
         "main":{
            "temp":10.12,
            "feels_like":6.8,
            "temp_min":10.12,
            "temp_max":10.12,
            "pressure":1013,
            "sea_level":1013,
            "grnd_level":997,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10n"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.5,
            "deg":78
         },
         "rain":{
            "3h":0.89
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-02 21:00:00"
      },
      {
         "dt":1591142400,
         "main":{
            "temp":10.06,
            "feels_like":6.78,
            "temp_min":10.06,
            "temp_max":10.06,
            "pressure":1013,
            "sea_level":1013,
            "grnd_level":997,
            "humidity":95,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10n"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.49,
            "deg":87
         },
         "rain":{
            "3h":0.65
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-03 00:00:00"
      },
      {
         "dt":1591153200,
         "main":{
            "temp":10.19,
            "feels_like":7.11,
            "temp_min":10.19,
            "temp_max":10.19,
            "pressure":1012,
            "sea_level":1012,
            "grnd_level":996,
            "humidity":96,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.3,
            "deg":86
         },
         "rain":{
            "3h":0.13
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 03:00:00"
      },
      {
         "dt":1591164000,
         "main":{
            "temp":11.06,
            "feels_like":8.03,
            "temp_min":11.06,
            "temp_max":11.06,
            "pressure":1013,
            "sea_level":1013,
            "grnd_level":997,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.45,
            "deg":83
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 06:00:00"
      },
      {
         "dt":1591174800,
         "main":{
            "temp":12.92,
            "feels_like":10.34,
            "temp_min":12.92,
            "temp_max":12.92,
            "pressure":1013,
            "sea_level":1013,
            "grnd_level":997,
            "humidity":88,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.14,
            "deg":82
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 09:00:00"
      },
      {
         "dt":1591185600,
         "main":{
            "temp":14.97,
            "feels_like":12.21,
            "temp_min":14.97,
            "temp_max":14.97,
            "pressure":1013,
            "sea_level":1013,
            "grnd_level":997,
            "humidity":79,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.55,
            "deg":85
         },
         "rain":{
            "3h":0.19
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 12:00:00"
      },
      {
         "dt":1591196400,
         "main":{
            "temp":15.32,
            "feels_like":12.27,
            "temp_min":15.32,
            "temp_max":15.32,
            "pressure":1012,
            "sea_level":1012,
            "grnd_level":996,
            "humidity":76,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":4.87,
            "deg":86
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 15:00:00"
      },
      {
         "dt":1591207200,
         "main":{
            "temp":11.77,
            "feels_like":9.6,
            "temp_min":11.77,
            "temp_max":11.77,
            "pressure":1012,
            "sea_level":1012,
            "grnd_level":996,
            "humidity":92,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04d"
            }
         ],
         "clouds":{
            "all":93
         },
         "wind":{
            "speed":3.37,
            "deg":82
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-03 18:00:00"
      },
      {
         "dt":1591218000,
         "main":{
            "temp":10.51,
            "feels_like":7.94,
            "temp_min":10.51,
            "temp_max":10.51,
            "pressure":1011,
            "sea_level":1011,
            "grnd_level":995,
            "humidity":96,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04n"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":3.7,
            "deg":80
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-03 21:00:00"
      },
      {
         "dt":1591228800,
         "main":{
            "temp":10.44,
            "feels_like":7.9,
            "temp_min":10.44,
            "temp_max":10.44,
            "pressure":1009,
            "sea_level":1009,
            "grnd_level":993,
            "humidity":95,
            "temp_kf":0
         },
         "weather":[
            {
               "id":804,
               "main":"Clouds",
               "description":"пасмурно",
               "icon":"04n"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":3.57,
            "deg":72
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-04 00:00:00"
      },
      {
         "dt":1591239600,
         "main":{
            "temp":12.13,
            "feels_like":8.99,
            "temp_min":12.13,
            "temp_max":12.13,
            "pressure":1007,
            "sea_level":1007,
            "grnd_level":991,
            "humidity":95,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.1,
            "deg":70
         },
         "rain":{
            "3h":2.03
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 03:00:00"
      },
      {
         "dt":1591250400,
         "main":{
            "temp":11.91,
            "feels_like":8.26,
            "temp_min":11.91,
            "temp_max":11.91,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":96,
            "temp_kf":0
         },
         "weather":[
            {
               "id":501,
               "main":"Rain",
               "description":"дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.8,
            "deg":93
         },
         "rain":{
            "3h":10.31
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 06:00:00"
      },
      {
         "dt":1591261200,
         "main":{
            "temp":12.14,
            "feels_like":8.4,
            "temp_min":12.14,
            "temp_max":12.14,
            "pressure":1005,
            "sea_level":1005,
            "grnd_level":990,
            "humidity":95,
            "temp_kf":0
         },
         "weather":[
            {
               "id":501,
               "main":"Rain",
               "description":"дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.96,
            "deg":110
         },
         "rain":{
            "3h":4.32
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 09:00:00"
      },
      {
         "dt":1591272000,
         "main":{
            "temp":13.43,
            "feels_like":10.41,
            "temp_min":13.43,
            "temp_max":13.43,
            "pressure":1005,
            "sea_level":1005,
            "grnd_level":990,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":5.42,
            "deg":121
         },
         "rain":{
            "3h":1.82
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 12:00:00"
      },
      {
         "dt":1591282800,
         "main":{
            "temp":14.61,
            "feels_like":12.17,
            "temp_min":14.61,
            "temp_max":14.61,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":92,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":99
         },
         "wind":{
            "speed":4.97,
            "deg":122
         },
         "rain":{
            "3h":0.35
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 15:00:00"
      },
      {
         "dt":1591293600,
         "main":{
            "temp":13.21,
            "feels_like":11.88,
            "temp_min":13.21,
            "temp_max":13.21,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":94,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":100
         },
         "wind":{
            "speed":2.9,
            "deg":130
         },
         "rain":{
            "3h":0.91
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-04 18:00:00"
      },
      {
         "dt":1591304400,
         "main":{
            "temp":10.55,
            "feels_like":8.67,
            "temp_min":10.55,
            "temp_max":10.55,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":96,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10n"
            }
         ],
         "clouds":{
            "all":18
         },
         "wind":{
            "speed":2.73,
            "deg":133
         },
         "rain":{
            "3h":0.31
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-04 21:00:00"
      },
      {
         "dt":1591315200,
         "main":{
            "temp":9.17,
            "feels_like":7.01,
            "temp_min":9.17,
            "temp_max":9.17,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":96,
            "temp_kf":0
         },
         "weather":[
            {
               "id":801,
               "main":"Clouds",
               "description":"небольшая облачность",
               "icon":"02n"
            }
         ],
         "clouds":{
            "all":12
         },
         "wind":{
            "speed":2.62,
            "deg":144
         },
         "sys":{
            "pod":"n"
         },
         "dt_txt":"2020-06-05 00:00:00"
      },
      {
         "dt":1591326000,
         "main":{
            "temp":10.62,
            "feels_like":8.6,
            "temp_min":10.62,
            "temp_max":10.62,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":95,
            "temp_kf":0
         },
         "weather":[
            {
               "id":800,
               "main":"Clear",
               "description":"ясно",
               "icon":"01d"
            }
         ],
         "clouds":{
            "all":7
         },
         "wind":{
            "speed":2.9,
            "deg":165
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-05 03:00:00"
      },
      {
         "dt":1591336800,
         "main":{
            "temp":15.27,
            "feels_like":13.42,
            "temp_min":15.27,
            "temp_max":15.27,
            "pressure":1006,
            "sea_level":1006,
            "grnd_level":990,
            "humidity":82,
            "temp_kf":0
         },
         "weather":[
            {
               "id":801,
               "main":"Clouds",
               "description":"небольшая облачность",
               "icon":"02d"
            }
         ],
         "clouds":{
            "all":14
         },
         "wind":{
            "speed":3.62,
            "deg":163
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-05 06:00:00"
      },
      {
         "dt":1591347600,
         "main":{
            "temp":17.77,
            "feels_like":15.43,
            "temp_min":17.77,
            "temp_max":17.77,
            "pressure":1005,
            "sea_level":1005,
            "grnd_level":990,
            "humidity":70,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":56
         },
         "wind":{
            "speed":4.32,
            "deg":159
         },
         "rain":{
            "3h":0.88
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-05 09:00:00"
      },
      {
         "dt":1591358400,
         "main":{
            "temp":17.6,
            "feels_like":15.18,
            "temp_min":17.6,
            "temp_max":17.6,
            "pressure":1004,
            "sea_level":1004,
            "grnd_level":989,
            "humidity":75,
            "temp_kf":0
         },
         "weather":[
            {
               "id":500,
               "main":"Rain",
               "description":"небольшой дождь",
               "icon":"10d"
            }
         ],
         "clouds":{
            "all":77
         },
         "wind":{
            "speed":4.84,
            "deg":157
         },
         "rain":{
            "3h":1.92
         },
         "sys":{
            "pod":"d"
         },
         "dt_txt":"2020-06-05 12:00:00"
      }
   ],
   "city":{
      "id":480060,
      "name":"Тверь",
      "coord":{
         "lat":56.8619,
         "lon":35.8931
      },
      "country":"RU",
      "population":400212,
      "timezone":10800,
      "sunrise":1590886394,
      "sunset":1590948925
   }
}
*/
