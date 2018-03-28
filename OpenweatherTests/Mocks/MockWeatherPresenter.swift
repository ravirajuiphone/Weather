//
//  MockWeatherPresenter.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
@testable import Openweather

class MockWeatherPresenter: WeatherPresenterProtocol {
    var view: WeatherViewProtocol?
    var interactor: WeatherInteractorProtocol?
    var loadWeatherInfoCalled = false
    var showInMapsTappedCalled = false
    var router: WeatherWireframe?
    
    func loadWeatherInfo() {
        loadWeatherInfoCalled = true
    }

    func showInMapsTapped() {
        showInMapsTappedCalled = true
    }
    
}
