//
//  WeatherApiService.swift
//  Openweather
//
//  Created by Raviraju Vysyaraju on 27/03/2018.
//  Copyright © 2018 Raviraju Vysyaraju. All rights reserved.
//

import UIKit
struct API {
    static let baseUrl = "http://samples.openweathermap.org/data/2.5/forecast?lat=%f&lon=%f&appid=b6907d289e10d714a6e88b30761fae22"
    static let baseUrlName = "http://samples.openweathermap.org/data/2.5/forecast?q=London,usl&appid=b6907d289e10d714a6e88b30761fae22"
}
class WeatherApiService: NSObject {
    static let session = URLSession.shared
    
    static func getAPIBaseUrl() -> URL{
        return  URL(string: String(format: API.baseUrlName))!
    }
    
    static func weatherForeCastInfo(completionHandler:  @escaping (URL?, WeatherFullInfo?) -> Swift.Void,
                             compltionFailedHandler: @escaping (Error?) -> Swift.Void) {
        
        let task = WeatherApiService.session.dataTask(with: WeatherApiService.getAPIBaseUrl(), completionHandler: { (data, response, error) in
            //let jsonString = String(data: data!, encoding: .utf8)
            if error == nil {
                let jsonDecoder = JSONDecoder()
                let weatherData = try! jsonDecoder.decode(WeatherFullInfo.self, from: data!)
                if let cod: String = weatherData.cod {
                    print(cod)
                }
                completionHandler(response?.url, weatherData)
            } else {
                compltionFailedHandler(error)
            }
            
        })
        task.resume()
    }
}
