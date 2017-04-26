//
//  WTRequestEndpointsTest.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import WTTest

class WTWeatherServiceTest: XCTestCase, WTWeatherDataDelegate {
    
    var requestFactory: WTRequestFactory!
    var parser : WTResponseParser!
    var requestSender: WTRequestSender!
    var weatherService: WTWeatherService!
    
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        
        // Initialise the weatherService
        class WTRequestFactoryMock: WTRequestFactory {
            
            override func dataRequestWithMethod(method: String, endpoint: String) -> URLRequest? {
                
                let url = URL(string: "http://api.openweathermap.org/data/2.5/forecast?q=London,uk&APPID=87c0d4c1b5958d7a87d3de15edc74a5f")!
                let request = URLRequest.init(url: url as URL)
                return request
            }
        }
        
        // Initialise the requestSender with mocks
        requestFactory = WTRequestFactoryMock()
        parser = WTResponseParser()
    
        requestSender = WTRequestSender(requestFactory: requestFactory, parser: parser)
        
        weatherService = WTWeatherService(requestSender: requestSender, dataDelegate: self)
        
        // Stub URLSession
        stub(condition: isHost("api.openweathermap.org")) { _ in
            // Stub it with test.json stub file
            return OHHTTPStubsResponse(
                fileAtPath: OHPathForFile("test.json", type(of: self))!,
                statusCode: 200,
                headers: ["Content-Type":"application/json"]
            )

        }
    }
    
    override func tearDown() {
        
        // Remove everything
        OHHTTPStubs.removeAllStubs()
        
        super.tearDown()
        
    }
    
    func testGetWeather() {
        
        expectation = expectation(description: "weatherRequestExpectation")
        
        weatherService.getWeather()
        
        waitForExpectations(timeout: 5) { error in
            // timeout is automatically treated as a failed test
        }
    }
    
    //MARK: WTWeatherDataDelegate
    func weatherDataReceived(data: WTWeather) {
        
        if data.items.count == 40 && expectation.description == "weatherRequestExpectation" {
            expectation.fulfill()
        }
    }

    func weatherDataFailure(error: WTWeatherError) {
        XCTFail()
    }
    
}
