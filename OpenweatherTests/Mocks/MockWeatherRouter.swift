//
//  MockWeatherRouter.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
@testable import Openweather

class MockWeatherRouter: WeatherWireframe {
    var mapViewControllerPresented = false
    func presentMapViewController() {
        mapViewControllerPresented = true
    }
}
