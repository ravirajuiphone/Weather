//
//  WeatherRouter.swift
//  Openweather
//
//  Created by Raviraju Vysyaraju on 27/03/2018.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import UIKit

protocol WeatherWireframe: class {
    func presentMapViewController()
}

class WeatherRouter: WeatherWireframe {
    private var navigationController: UINavigationController
    init(navigationVC: UINavigationController) {
        self.navigationController = navigationVC
    }
    func presentMapViewController(){
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "MapViewController") as? MapViewController {
            self.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
