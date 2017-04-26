//
//  WTNetworkDelegate.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import Foundation

protocol WTNetworkDelegate: AnyObject {
    
    func requestProcessed(type: WTRequestType, data: Any)
    func requestFailed(type: WTRequestType, httpCode: Int?)
    
}
