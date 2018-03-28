//
//  WeatherPresenter.swift
//  Openweather
//
//  Created by Raviraju Vysyaraju on 27/03/18.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import Foundation
import UIKit

protocol WeatherPresenterProtocol {
    weak var view: WeatherViewProtocol? { get }
    var interactor: WeatherInteractorProtocol? { get }
    var router: WeatherWireframe? { get }
    func loadWeatherInfo()
    func showInMapsTapped()
}

class WeatherPresenter: WeatherPresenterProtocol {
    private var navigationController: UINavigationController
    private var reachability: Reachability!
    var interactor: WeatherInteractorProtocol?
    var view: WeatherViewProtocol?
    var router: WeatherWireframe?
    private var locationManager: LocationManager

    init(navigation: UINavigationController,
         view: WeatherViewProtocol,
         interactor: WeatherInteractorProtocol,
         reachability: Reachability = Reachability()!,
         locationManager: LocationManager = LocationManager.sharedInstance) {
        self.view = view
        self.interactor = interactor
        self.navigationController = navigation
        self.reachability = reachability
        self.router = WeatherRouter(navigationVC: navigation)
        self.locationManager = locationManager
    }
    
    func showInMapsTapped() {
        if locationManager.isLocationServicesEnabled(){
            self.router?.presentMapViewController()
        } else {
            let actionSheetController: UIAlertController = UIAlertController(title: "Location", message: "Please allow location services to continue", preferredStyle: .alert)
            let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in
                //Just dismiss the action sheet
            }
            actionSheetController.addAction(cancelAction)
            let action = UIAlertAction(title: "Settings", style: .default, handler: { (alert) in
                if let url = URL(string:UIApplicationOpenSettingsURLString) {
                    if UIApplication.shared.canOpenURL(url) {
                        _ =  UIApplication.shared.open(url, options: [:], completionHandler: nil)
                    }
                }
            })
            actionSheetController.addAction(action)
            self.navigationController.present(actionSheetController, animated: true, completion: nil)
        }
    }
    
    func loadWeatherInfo() {
        if self.reachability.isReachable {
            self.interactor?.fetchWeatherInfo()
        } else {
            self.showNoInternetAlert()
        }
    }

    private func showNoInternetAlert() {
        let alert = UIAlertController(title: "Error", message: "Please check your internet connection", preferredStyle: .alert)
        self.navigationController.present(alert, animated: true, completion: nil)
    }
}

extension WeatherPresenter: WeatherInteractorOutput {

    func weatherInfoFetched(weatherList: [WeatherDetails],
                            weatherFullInfo: WeatherFullInfo?,
                            weatherDetails: [String : [WeatherDetails]]?,
                            weatherDates: [String]?) {
        self.view?.showWeatherInfo(weatherList: weatherList,
                                   weatherFullInfo: weatherFullInfo,
                                   weatherDetails: weatherDetails,
                                   weatherDates: weatherDates)
    }

    func weatherFetchFailed() {
        //Show alert when it's failed
    }
}
