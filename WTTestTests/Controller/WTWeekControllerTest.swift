//
//  WTWeekControllerTest.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import XCTest
import OHHTTPStubs
@testable import WTTest

class WTWeekControllerTest: XCTestCase {
    
    let testBundle = Bundle(for: WTResponseParserTest.self)
    var parser: WTResponseParser!
    var json: Dictionary<String, AnyObject>!
    var data: WTWeather!
    var weekController: WTWeekController!
    var tableView: UITableView!
    
    override func setUp() {
        super.setUp()
        
        if let url = testBundle.url(forResource: "test", withExtension: "json") {
            let data = try! Data(contentsOf: url)
            json = try! JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? Dictionary<String,AnyObject>
            
        } else {
            XCTFail()
        }
        
        data = WTWeather(json: json)
        tableView = UITableView()
        
        weekController = WTWeekController(tableView: tableView, dataSource: data)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNumberOfRows() {
        
        XCTAssertTrue(tableView.numberOfRows(inSection: 0) == 6, "Wrong number of rows")
        
    }
    
}
