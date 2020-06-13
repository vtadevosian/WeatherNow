//
//  ViewController.swift
//  WeatherNow
//
//  Created by Vahram Tadevosian on 6/11/20.
//  Copyright © 2020 Vahram Tadevosian. All rights reserved.
//

import UIKit

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(_ error: Error)
}

class WeatherViewController: UIViewController {

    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    
    var weatherManager = WeatherManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTextField.delegate = self
        weatherManager.delegate = self
    }

    @IBAction func searchButtonPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        weatherManager.fetchWeather(for: searchTextField.text ?? "")
    }

}

extension WeatherViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        weatherManager.fetchWeather(for: searchTextField.text ?? "")
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let city = searchTextField.text {
            weatherManager.fetchWeather(for: city)
        }
        searchTextField.text = ""
    }
}

extension WeatherViewController: WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel) {
        DispatchQueue.main.async {
            self.temperatureLabel.text = weather.temperatureString
            self.conditionImageView.image = UIImage(systemName: weather.conditionName)
            self.locationLabel.text = weather.cityName
            self.conditionLabel.text = weather.description
            
        }
    }
    
    func didFailWithError(_ error: Error) {
        print(error)
    }
}
