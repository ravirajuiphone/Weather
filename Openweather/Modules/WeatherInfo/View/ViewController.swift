//
//  ViewController.swift
//  Openweather
//
//  Created by Raviraju Vysyaraju on 22/03/2018.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import UIKit

protocol WeatherViewProtocol: class {
    var presenter: PresenterProtocol? { get set }

    func showWeatherInfo(weatherList: [WeatherDetails],
                         weatherFullInfo: WeatherFullInfo?,
                         weatherDetails: [String: [WeatherDetails]]?,
                         weatherDates: [String]?)
}

class ViewController: UIViewController {
    var imageCache: ImageCache!
    private var weatherList = [WeatherDetails]()
    private var weatherFullInfo: WeatherFullInfo?
    private var weatherDetails: [String: [WeatherDetails]]?
    private var weatherDates: [String]?
    @IBOutlet weak var weatherTabelview: UITableView!
    var presenter: PresenterProtocol?
    
    fileprivate func setupView() {
        let nibName = UINib(nibName: "WeatherInfoTableViewCell", bundle: nil)
        self.weatherTabelview.register(nibName, forCellReuseIdentifier: "WeatherTableviewCell")
        self.weatherTabelview.estimatedRowHeight = 60.0
        self.weatherTabelview.rowHeight = UITableViewAutomaticDimension
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Maps", style: .plain, target: self, action: #selector(showInMapsTapped))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageCache = ImageCache(shared: URLSession.shared, sessionTask: URLSessionDataTask())
        setupView()
        presenter?.loadWeatherInfo()
    }

    //Load custome cell
    func loadCustomeCell(cell: WeatherInfoTableViewCell, indexPath: IndexPath) {
        if let weatherInfo = self.weatherDetails,
            let title: String =  self.weatherDates?[indexPath.section],
            let weather: [WeatherDetails] = weatherInfo[title] {
            let weatherDetails = weather[indexPath.row]
            cell.weatherLabelTitle?.text = weatherDetails.dt_txt?.components(separatedBy: " ").last
            cell.tag = indexPath.row
            // Info parts
            var infoParts: [String] = []
            // Weather description
            if let weatherDescription = weatherDetails.weather?.first?.description?.capitalized {
                infoParts.append(weatherDescription)
            }
            // Temp
            if let temp = weatherDetails.main?.temp {
                infoParts.append("🌡 \(temp)°")
            }
            // Wind speed
            if let wind = weatherDetails.wind?.speed {
                infoParts.append("🌬 \(wind)m/s")
            }
            
            // Set labels
            cell.weatheLabelDetailsTitle?.text = infoParts.joined(separator: "   ")
            DispatchQueue.global(qos: .background).async {
                if let imgUri = weatherDetails.weather?.first?.icon {
                    self.imageCache.imageFor(uriString: imgUri) { (image, error) in
                        if error == nil {
                            DispatchQueue.main.async() {
                                if cell.tag == indexPath.row {
                                    cell.weatherIcon?.image = image
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    //MARK: Orientation
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    //MARK: Show MAP View
    @objc func showInMapsTapped(){
        presenter?.showInMapsTapped()
    }
}

//MARK: WeatherViewProtocol

extension ViewController: WeatherViewProtocol {
    func showWeatherInfo(weatherList: [WeatherDetails],
                         weatherFullInfo: WeatherFullInfo?,
                         weatherDetails: [String : [WeatherDetails]]?,
                         weatherDates: [String]?) {
        self.weatherList = weatherList
        self.weatherFullInfo = weatherFullInfo
        self.weatherDetails = weatherDetails
        self.weatherDates = weatherDates
        DispatchQueue.main.async() {
            self.weatherTabelview.reloadData()
        }
    }
}

//MARK: UITableViewDelegate Methods

extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let count = self.weatherDates?.count {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let weatherDates = weatherDates ,let weatherDetails = self.weatherDetails {
            if let weatherInfo = weatherDetails[weatherDates[section]]{
                return weatherInfo.count
            }
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = self.weatherTabelview.dequeueReusableCell(withIdentifier: "WeatherTableviewCell", for: indexPath) as? WeatherInfoTableViewCell {
            loadCustomeCell(cell: cell, indexPath: indexPath)
            return cell
        }
       return UITableViewCell()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        //var date = NSDate(timeIntervalSinceReferenceDate: 123)
        if let weatherDates = weatherDates ,let weatherDetails = self.weatherDetails {
            if let weatherInfo: WeatherDetails = weatherDetails[weatherDates[section]]?.first{
                return weatherInfo.weatherDateString
            }
        }
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        header.textLabel?.frame = header.frame
        header.textLabel?.textAlignment = .left
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
}
