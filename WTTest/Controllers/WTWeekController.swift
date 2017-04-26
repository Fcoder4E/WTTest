//
//  WTWeekController.swift
//  WTTest
//
//  Created by Fabio on 25/04/2017.
//  Copyright © 2017 Fabio. All rights reserved.
//

import UIKit

class WTWeekController: NSObject {
    
    // the key of these dictionaries is indexPath.row
    var collectionsHolder = Dictionary<Int,WTCollectionViewController>()
    var collectionsData = Dictionary<Int,Array<WTWeatherItem>>()
    
    var weekDataSource: WTWeather?
    
    init(tableView: UITableView, dataSource: WTWeather) {
        super.init()
        tableView.dataSource = self
        tableView.delegate = self
        self.weekDataSource = dataSource
        initCollectionViewsDataSources(items: dataSource.items)
        tableView.reloadData()
    }
    
    /**
     Divides WeatherItems by day and put each day in the collectionsData Dictionary.
     */
    private func initCollectionViewsDataSources(items: Array<WTWeatherItem>) {
        
        var currentDay = items.first?.dt.formatDate()
        var groupIndex = 0
        var currentDayItems = Array<WTWeatherItem>()
        
        for item in items {
            
            if item.dt.formatDate() == currentDay {
                currentDayItems.append(item)
            } else {
                collectionsData[groupIndex] = currentDayItems
                currentDayItems.removeAll()
                currentDayItems.append(item)
                currentDay = item.dt.formatDate()
                groupIndex += 1
            }
        }
        
        collectionsData[groupIndex] = currentDayItems
    }
}

extension WTWeekController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collectionsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellID: String = "WTWeatherCellID"
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID) as! WTWeatherCell
        var collectionRowController: WTCollectionViewController
        // Create a CollectionViewController for the CollectionView in this row
        // if it doesn't exist, get it from memory if it had already been created
        if let collectionController = collectionsHolder[indexPath.row] {
            collectionRowController = collectionController
        } else {
            collectionRowController = WTCollectionViewController()
            collectionRowController.view = cell.collectionView
            collectionsHolder[indexPath.row] = collectionRowController
        }
        
        cell.dateTimeLabel.text = collectionsData[indexPath.row]?.first?.dt.friendlyDate()
        
        return cell
    }
}

extension WTWeekController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // get the CollectionViewController for this row
        let collectionRowController = collectionsHolder[indexPath.row]
        // set the datasource for the CollecionView
        (collectionRowController?.view as! UICollectionView).dataSource = collectionRowController
        // set the datasource for the CollecionViewController
        collectionRowController?.dayDataSource = collectionsData[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // CollectionViewController no longer needed
        collectionsHolder[indexPath.row] = nil
    }
}
