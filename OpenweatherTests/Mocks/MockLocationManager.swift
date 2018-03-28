//
//  MockLocationManager.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
@testable import Openweather

class MockLocationManager: LocationManager {
    var locationEnabled = false
    override func isLocationServicesEnabled() -> Bool {
        return locationEnabled
    }
}
