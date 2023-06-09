//
//  FavoriteBeersRouter.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 12.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol FavoriteBeersRoutingLogic {
    func routeToDetail(segue: UIStoryboardSegue?)
}

protocol FavoriteBeersDataPassing {
    var dataStore: FavoriteBeersDataStore? { get }
}

class FavoriteBeersRouter: NSObject, FavoriteBeersRoutingLogic, FavoriteBeersDataPassing {
    weak var viewController: FavoriteBeersViewController?
    var dataStore: FavoriteBeersDataStore?
  
  // MARK: Routing
  
    func routeToDetail(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Storyboards.detail.rawValue, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.detail.rawValue) as! DetailViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToDetail(source: dataStore!, destination: &destinationDS)
            navigateToDetail(source: viewController!, destination: destinationVC)
        }
    }

    // MARK: Navigation
  
    func navigateToDetail(source: FavoriteBeersViewController, destination: DetailViewController) {
        source.show(destination, sender: nil)
    }
  
    // MARK: Passing data
    
    func passDataToDetail(source: FavoriteBeersDataStore, destination: inout DetailDataStore) {
        let selectedRow = viewController?.tableView.indexPathForSelectedRow?.row
        let selectedBeer = source.beers[selectedRow!]
        destination.beer = selectedBeer
    }
}
