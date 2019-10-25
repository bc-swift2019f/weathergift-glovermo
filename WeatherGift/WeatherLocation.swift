//
//  WeatherLocation.swift
//  WeatherGift
//
//  Created by Morgan Glover on 10/18/19.
//  Copyright © 2019 Morgan Glover. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherLocation {
    struct DailyForecast {
        var dailyMaxTemp: Double
        var dailyMinTemp: Double
        var dailySummary: String
        var dailyDate: Double
        var dailyIcon: String
    }
    
    struct HourlyForecast {
        var hourlyTime: Double
        var hourlyTemperature: Double
        var hourlyPrecipProb: Double
        var hourlyIcon: String
    }
    
    var name = ""
    var coordinates = ""
    var currentTemp = "--"
    var dailySummary = ""
    var currentIcon = ""
    var currentTime = 0.0
    var timeZone = ""
    
    var dailyForecastArray = [DailyForecast]()
    var hourlyForecastArray = [HourlyForecast]()
    
    func getWeather(completed: @escaping () -> ()) {
        let weatherURL = urlBase + urlAPIKey + coordinates
        Alamofire.request(weatherURL).responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                // Data for summary view at top
                if let temperature = json["currently"]["temperature"].double {
                    print("***** temperature inside getWeather = \(temperature)")
                    let roundedTemp = String(format: "%3.f", temperature)
                    self.currentTemp = roundedTemp + "°"
                } else {
                    print("Could not return a temperature")
                }
                if let summary = json["daily"]["summary"].string {
                    self.dailySummary = summary
                } else {
                    print("Could not return a daily summary")
                }
                if let icon = json["currently"]["icon"].string {
                    self.currentIcon = icon
                } else {
                    print("Could not return an icon")
                }
                if let time = json["currently"]["time"].double {
                    self.currentTime = time
                } else {
                    print("Could not return time")
                }
                if let timeZone = json["timezone"].string {
                    self.timeZone = timeZone
                } else {
                    print("Could not return an icon")
                }
                
                // Data for daily TableView
                let dailyDataArray = json["daily"]["data"]
                self.dailyForecastArray = []
                let days = min(7, dailyDataArray.count-1)
                for day in 1...days {
                    let maxTemp = json["daily"]["data"][day]["temperatureHigh"].doubleValue
                    let minTemp = json["daily"]["data"][day]["temperatureLow"].doubleValue
                    let summary = json["daily"]["data"][day]["summary"].stringValue
                    let date = json["daily"]["data"][day]["time"].doubleValue
                    let icon = json["daily"]["data"][day]["icon"].stringValue
                    let newDailyForecast = DailyForecast(dailyMaxTemp: maxTemp, dailyMinTemp: minTemp, dailySummary: summary, dailyDate: date, dailyIcon: icon)
                    self.dailyForecastArray.append(newDailyForecast)
                }
                
                // Data for hourly CollectionView
                let hourlyDataArray = json["hourly"]["data"]
                self.hourlyForecastArray = []
                let hours = min(24, hourlyDataArray.count-1)
                for hour in 1...hours {
                    let time = json["hourly"]["data"][hour]["time"].doubleValue
                    let temperature = json["hourly"]["data"][hour]["temperature"].doubleValue
                    let precipProb = json["hourly"]["data"][hour]["precipProbability"].doubleValue
                    let icon = json["hourly"]["data"][hour]["icon"].stringValue
                    let newHourlyForecast = HourlyForecast(hourlyTime: time, hourlyTemperature: temperature, hourlyPrecipProb: precipProb, hourlyIcon: icon)
                    self.hourlyForecastArray.append(newHourlyForecast)
                }
            case .failure(let error):
                print(error)
            }
            completed()
        }

    }
}
