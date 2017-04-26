//
//  WTEnum.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import Foundation

enum WTRequestType: Int {
    
    case GetWeather
    case Unknown
    
}

enum WTWeatherError: Error {

    case ParsingError
    case ClientError
    case ServerError
}
