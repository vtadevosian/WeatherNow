//
//  WeatherModel.swift
//  WeatherNow
//
//  Created by Vahram Tadevosian on 6/12/20.
//  Copyright © 2020 Vahram Tadevosian. All rights reserved.
//

import Foundation

struct WeatherModel {
    let conditionID: Int
    let cityName: String
    let temperature: Double
    let dt: TimeInterval
    let description: String
    
    var temperatureString: String {
        return String(format: "%.1f", temperature)
    }
    
    var dateTime: String {
        let dateZeroTZ = Date(timeIntervalSince1970: dt)
        return ""
    }
    
    var conditionName: String {
        switch conditionID {
        case 200..<210, 230..<240:
            return "cloud.bolt.rain.fill"
        case 210..<230, 240..<300:
            return "cloud.bolt.fill"
        case 300..<500, 520..<540:
            return "cloud.drizzle.fill"
        case 500, 501:
            return "cloud.rain.fill"
        case 502...504:
            return "cloud.heavyrain.fill"
        case 511:
            return "cloud.snow.fill"
        case 600..<610, 622:
            return "snow"
        case 610..<622:
            return "cloud.sleet.fill"
        case 701, 720...770:
            return "cloud.fog.fill"
        case 711:
            return "smoke.fill"
        case 771:
            return "wind"
        case 781:
            return "tornado"
        case 800:
            return "sun.min.fill" // "moon.fill"
        case 801:
            return "cloud.sun.fill" // "cloud.moon.fill"
        case 802:
            return "cloud"
        case 803, 804:
            return "cloud.fill"
        default:
            return "cloud"
        }
    }
}
