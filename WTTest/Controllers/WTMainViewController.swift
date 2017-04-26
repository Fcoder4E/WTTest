//
//  WTMainViewController.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import UIKit

class WTMainViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView!
    
    // dependencies
    var requestSender: WTRequestSender!
    var weatherService: WTWeatherService!
    
    var weekController: WTWeekController?
    
    fileprivate let refreshControl = UIRefreshControl()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl.addTarget(self, action: #selector(WTMainViewController.refreshData(sender:)), for: UIControlEvents.valueChanged)
        self.table.refreshControl = refreshControl
        
        // Initialise the WTWeatherService
        let requestFactory = WTRequestFactory()
        let parser = WTResponseParser()
        requestSender = WTRequestSender(requestFactory: requestFactory, parser: parser)
        weatherService = WTWeatherService(requestSender: requestSender, dataDelegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshData(sender: refreshControl)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func refreshData(sender: UIRefreshControl) {
        
        // execute the weatherService request
        weatherService.getWeather()
    }
    
    fileprivate func showErrorAlert() {
        
        let alertController = UIAlertController(title: "Sorry!", message: "An error has occured;\nPlease try again later.", preferredStyle: .alert)
        
        // Create the actions
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) {
            UIAlertAction in
        }
        // Add the actions
        alertController.addAction(cancelAction)
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
}

extension WTMainViewController: WTWeatherDataDelegate {

    func weatherDataReceived(data: WTWeather) {
        refreshControl.endRefreshing()
        weekController = WTWeekController(tableView: self.table, dataSource: data)
    }
    
    func weatherDataFailure(error: WTWeatherError) {
        refreshControl.endRefreshing()
        // TODO: customize message accordingly to the received error
        showErrorAlert()
    }
}
