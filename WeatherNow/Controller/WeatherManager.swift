//
//  WeatherManager.swift
//  WeatherNow
//
//  Created by Vahram Tadevosian on 6/12/20.
//  Copyright © 2020 Vahram Tadevosian. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

struct WeatherManager {
    private let url = "https://api.openweathermap.org/data/2.5/weather?appid=aa267af1d88a04de4dd1dfb5e974c00d&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(for cityName: String) {
        let urlString = "\(url)&q=\(cityName)"
        request(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(url)&lat=\(latitude)&lon=\(longitude)"
        request(with: urlString)
    }
    
    func request(with urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let urlSession = URLSession(configuration: .default)
        
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            if let error = error {
                self.delegate?.didFailWithError(error)
                return
            }
            
            guard let weatherData = data,
                let weather = self.parseJSON(weatherData) else { return }
            self.delegate?.didUpdateWeather(self, weather: weather)
        }
        
        dataTask.resume()
    }
    
    private func parseJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: weatherData)
            
            let cityName = weatherData.name
            let temperature = weatherData.main.temp
            let conditionID = weatherData.weather[0].id
            let description = weatherData.weather[0].description.capitalizingFirstLetter()
            let datetime = weatherData.dt
            let sunriseTime = weatherData.sys.sunrise
            let sunsetTime = weatherData.sys.sunset
            return WeatherModel(cityName: cityName,
                                temperature: temperature,
                                conditionID: conditionID,
                                description: description,
                                dt: datetime,
                                sunriseTime: sunriseTime,
                                sunsetTime: sunsetTime)
        } catch {
            delegate?.didFailWithError(error)
            return nil
        }
    }
    
}
