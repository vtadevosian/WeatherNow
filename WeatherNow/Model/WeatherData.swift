//
//  WeatherData.swift
//  WeatherNow
//
//  Created by Vahram Tadevosian on 6/12/20.
//  Copyright © 2020 Vahram Tadevosian. All rights reserved.
//

import Foundation

struct Sys: Codable {
    let sunrise: Double
    let sunset: Double
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let id: Int
    let main: String
    let description: String
}

struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let dt: Double
    let sys: Sys
}
