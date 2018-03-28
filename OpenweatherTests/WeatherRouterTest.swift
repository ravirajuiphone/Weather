//
//  WeatherRouterTest.swift
//  OpenweatherTests
//
//  Created by Raviraju Vysyaraju on 28/03/2018.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import XCTest

@testable import Openweather
class WeatherRouterTest: XCTestCase {
    var navController: MockNavigationController!
    var sut: MapViewController!
    var router: WeatherWireframe!
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
        navController = MockNavigationController(rootViewController: sut)
        router = WeatherRouter(navigationVC: navController)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
        navController = nil
        router = nil
    }
    
    func testPresentMapViewController() {
        router.presentMapViewController()
        XCTAssertNotNil(navController.viewControllerPushed as? MapViewController)
    }

}
