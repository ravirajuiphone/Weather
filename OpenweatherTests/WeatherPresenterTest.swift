//
//  WeatherPresenterTest.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju  on 28/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import XCTest
@testable import Openweather

class WeatherPresenterTest: XCTestCase {

    var sut: WeatherPresenter!
    var mockView = MockView()
    var mockInteractor = MockWeatherInteractor()
    var locationManager = MockLocationManager()
    var mockRouter = MockWeatherRouter()
    let navigationController = MockNavigationController()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        self.sut = WeatherPresenter(navigation: navigationController,
                                    view: MockView(),
                                    interactor: mockInteractor,
                                    locationManager: locationManager)
        self.sut.router = mockRouter
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testShowInMapsTapped() {
        locationManager.locationEnabled = true

        self.sut.showInMapsTapped()

        XCTAssertTrue(mockRouter.mapViewControllerPresented)
    }
    
    func testShowInMapsTapped_SettingDisbaled() {
        locationManager.locationEnabled = false
        
        self.sut.showInMapsTapped()
        XCTAssertNotNil(navigationController.viewPresented)
    }
    
    func testLoadWeatherInfo() {
        self.sut.loadWeatherInfo()
        XCTAssertTrue(mockInteractor.fetchWeatherInfoCalled)
    }
    
}
