//
//  LoginRouter.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 11.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

@objc protocol LoginRoutingLogic {
    func routeToTabBar(segue: UIStoryboardSegue?)
    func routeToRegistration(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing {
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    weak var viewController: LoginViewController?
    var dataStore: LoginDataStore?
  
    // MARK: Routing
  
    func routeToTabBar(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: Storyboards.tabBar.rawValue, bundle: nil)
          let destinationVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.tabBar.rawValue) as! UITabBarController
        navigateToTabBar(source: viewController!, destination: destinationVC)

  }
    
    func routeToRegistration(segue: UIStoryboardSegue?) {
        let storyboard = UIStoryboard(name: Storyboards.registration.rawValue, bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: ViewControllers.registration.rawValue) as! RegistrationViewController
        navigateToRegistration(source: viewController!, destination: destinationVC)
    }


  // MARK: Navigation
  
    func navigateToRegistration(source: LoginViewController, destination: RegistrationViewController) {
       source.show(destination, sender: nil)
    }
    
    func navigateToTabBar(source: LoginViewController, destination: UITabBarController) {
        source.show(destination, sender: nil)

    }
  
  // MARK: Passing data
    
    func passDataToMain(source: LoginDataStore, destination: inout UITabBarController) {
     // destination.name = source.name
    }
}
