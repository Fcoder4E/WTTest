//
//  WTRequestEndpoints.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import Foundation

protocol WTWeatherDataDelegate {
    
    func weatherDataReceived(data: WTWeather)
    func weatherDataFailure(error: WTWeatherError)
}

class WTWeatherService {
    
    var requestSender: WTRequestSender
    fileprivate var dataDelegate: WTWeatherDataDelegate!
    
    // needed for openweather.com requests
    private let APPID = "87c0d4c1b5958d7a87d3de15edc74a5f"
    
    init(requestSender: WTRequestSender, dataDelegate: WTWeatherDataDelegate) {
        
        self.requestSender = requestSender
        self.requestSender.delegate = self
        
        self.dataDelegate = dataDelegate
    }
    
    /**
     Send the request to get the weather.
     */
    func getWeather(city: String = "London", country: String = "uk", unit: String = "metric") {
        
        requestSender.sendDataRequest(method: "GET", endpoint: "data/2.5/forecast?q=\(city),\(country)&units=\(unit)&APPID=\(APPID)", type: .GetWeather)
        
    }

}

extension WTWeatherService: WTNetworkDelegate {
    
    func requestProcessed(type: WTRequestType, data: Any) {
        
        if let weather = data as? WTWeather,
            type == .GetWeather {
            log.debug("Weather data received")
            dataDelegate.weatherDataReceived(data: weather)
        }
    }
    
    func requestFailed(type: WTRequestType, httpCode: Int?) {
        
        log.error("Error receiving Weather data")
    
        var error = WTWeatherError.ParsingError
        
        if let code = httpCode {
            
            if code >= 400 && code < 500 {
                error = WTWeatherError.ClientError
            }
            
            if code >= 500 {
                error = WTWeatherError.ServerError
            }
        }
        
        dataDelegate.weatherDataFailure(error: error)
    }

}
