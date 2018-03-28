//
//  WeatherInteractor.swift
//  Openweather
//
//  Created by Raviraju Vysyaraju on 27/03/2018.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import UIKit


protocol WeatherInteractorOutput: class {
    func weatherInfoFetched(weatherList: [WeatherDetails],
                            weatherFullInfo: WeatherFullInfo?,
                            weatherDetails: [String: [WeatherDetails]]?,
                            weatherDates: [String]?)
    func weatherFetchFailed()
}


protocol WeatherInteractorProtocol: class {
    weak var output: WeatherInteractorOutput? { get set }
    
    func fetchWeatherInfo()
}


class WeatherInteractor: WeatherInteractorProtocol {
    weak var output: WeatherInteractorOutput?
    var weatherList = [WeatherDetails]()
    var weatherFullInfo: WeatherFullInfo?
    var weatherDetails: [String: [WeatherDetails]]?
    var weatherDates: [String]?

    func fetchWeatherInfo() {
       WeatherApiService.weatherForeCastInfo(completionHandler: { [weak self] url, response in
            if let weatherData = response {
                self?.processResponse(weatherData: weatherData)
            }
        }) { (error) in
            print(error?.localizedDescription ?? "")
            self.output?.weatherFetchFailed()
        }
    }

    func processResponse(weatherData: WeatherFullInfo) {
        self.weatherList = (weatherData.list?.sorted(by: { (weather1: WeatherDetails, weather2: WeatherDetails) -> Bool in
            let value =  weather1.dt! < weather2.dt!
            return value
        }))!
        print(self.weatherList)
        self.weatherDetails = self.getWeatherList()
        if let weather = self.weatherDetails {
            self.weatherDates = Array(weather.keys.sorted())
        }
        self.output?.weatherInfoFetched(weatherList: weatherList,
                                       weatherFullInfo: weatherFullInfo,
                                       weatherDetails: weatherDetails,
                                       weatherDates: weatherDates)
    }

    func getWeatherList() -> [String: [WeatherDetails]]? {
        let dict = self.weatherList.reduce([String: [WeatherDetails]]()) { (key, value: WeatherDetails) -> [String: [WeatherDetails]] in
            var key = key
            if let first = value.dt_txt?.components(separatedBy: " ").first {
                var array = key[first]
                if array == nil {
                    array = []
                }
                array!.append(value)
                key[first] = array!
            }
            return key
        }

        print(dict.keys.sorted())
        print(dict)
        return dict
    }

}
