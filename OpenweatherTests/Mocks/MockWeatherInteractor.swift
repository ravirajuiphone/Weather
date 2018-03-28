//
//  MockWeatherInteractor.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
@testable import Openweather

class MockWeatherInteractor: WeatherInteractorProtocol {
    var output: WeatherInteractorOutput?
    var fetchWeatherInfoCalled: Bool = false

    func fetchWeatherInfo() {
        fetchWeatherInfoCalled = true
    }
}

