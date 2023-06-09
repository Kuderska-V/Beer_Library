//
//  ProfileRouter.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol ProfileRoutingLogic {
    func routeToFavoriteBeers(segue: UIStoryboardSegue?)
    func routeToEdit(segue: UIStoryboardSegue?)
    func routeToLogin()
}

protocol ProfileDataPassing {
    var dataStore: ProfileDataStore? { get }
}

class ProfileRouter: NSObject, ProfileRoutingLogic, ProfileDataPassing {
    weak var viewController: ProfileViewController?
    var dataStore: ProfileDataStore?
  
    // MARK: Routing
    
    func routeToFavoriteBeers(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! FavoriteBeersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToFavorites(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Storyboards.favorites.rawValue, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.favorites.rawValue) as! FavoriteBeersViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToFavorites(source: dataStore!, destination: &destinationDS)
            navigateToFavorites(source: viewController!, destination: destinationVC)
        }
    }
    
    func routeToEdit(segue: UIStoryboardSegue?) {
        if let segue = segue {
            let destinationVC = segue.destination as! EditViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToEdit(source: dataStore!, destination: &destinationDS)
        } else {
            let storyboard = UIStoryboard(name: Storyboards.edit.rawValue, bundle: nil)
            let destinationVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.edit.rawValue) as! EditViewController
            var destinationDS = destinationVC.router!.dataStore!
            passDataToEdit(source: dataStore!, destination: &destinationDS)
            navigateToEdit(source: viewController!, destination: destinationVC)
        }
    }
    
    func routeToLogin() {
        let storyboard = UIStoryboard(name: Storyboards.login.rawValue, bundle: Bundle.main)
        let vc = storyboard.instantiateViewController(withIdentifier: ViewControllers.login.rawValue) as? LoginViewController
        let navVC = UINavigationController(rootViewController: vc!)
        viewController?.view.window?.rootViewController = navVC
        viewController?.view.window?.makeKeyAndVisible()
    }

  // MARK: Navigation
    
    func navigateToFavorites(source: ProfileViewController, destination: FavoriteBeersViewController) {
        source.show(destination, sender: nil)
    }
    
    func navigateToEdit(source: ProfileViewController, destination: EditViewController) {
        source.show(destination, sender: nil)
    }
  
  // MARK: Passing data
  
    func passDataToFavorites(source: ProfileDataStore, destination: inout FavoriteBeersDataStore) {
    }
    
    func passDataToEdit(source: ProfileDataStore, destination: inout EditDataStore) {
    }
}
