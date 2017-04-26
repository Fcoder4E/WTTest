//
//  WTLogger.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import Foundation

class WTLogger {
    
    static func networkRequestLog(request: URLRequest, type: WTRequestType) {
       
        //logging
        if let httpBody = request.httpBody {
            var bodyStr = ""
            if (httpBody.count > 5000) {
                bodyStr = "<\(httpBody.count / 1024) kBytes of data>"
            }
            else if let bodyStrUnwrapped = NSString(data: httpBody, encoding:String.Encoding.utf8.rawValue) as String? {
                bodyStr = bodyStrUnwrapped;
            }
            
            log.debug("\(String(describing: request.httpMethod)) -> \(String(describing: request.url?.absoluteString))\n type:\(type.rawValue), JSON:\n \(bodyStr)")
        }
    }
    
}
