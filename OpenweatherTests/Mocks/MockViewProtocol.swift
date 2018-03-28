//
//  MockViewProtocol.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
@testable import Openweather

class MockView: WeatherViewProtocol {
    var presenter: WeatherPresenterProtocol?
    var showWeatherInfoCalled = false

    func showWeatherInfo(weatherList: [WeatherDetails],
                         weatherFullInfo: WeatherFullInfo?,
                         weatherDetails: [String : [WeatherDetails]]?,
                         weatherDates: [String]?) {
        showWeatherInfoCalled = true
    }


}
