//
//  AppDelegate.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import UIKit
import XCGLogger

let log = XCGLogger.default

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // set up the logger framework
        log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, writeToFile: nil, fileLevel: .debug)
        
        return true
    }

}

