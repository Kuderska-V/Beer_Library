//
//  FavoriteBeersInteractor.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 12.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import CoreData
import UIKit

protocol FavoriteBeersBusinessLogic {
    func fetchBeers(request: FavoriteBeers.Show.Request)
    func sortBeersAscending()
    func sortBeersDescending()
}

protocol FavoriteBeersDataStore {
    var beers: [BeerItem] { get }
}

class FavoriteBeersInteractor: FavoriteBeersBusinessLogic, FavoriteBeersDataStore {
    var presenter: FavoriteBeersPresentationLogic?
    var beers: [BeerItem] = []
    let savedBeers = CoreDataManager()
  
    // MARK: Fetch Beers
  
    func fetchBeers(request: FavoriteBeers.Show.Request) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        guard let email = UserDefaults.standard.value(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) as? String else { return }
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "owner_email == %@", email)
        do {
            let beerManagedObjects = try managedContext.fetch(fetchRequest)
            beers = beerManagedObjects.map { BeerItem.from($0) }.sorted {
                return $0.createdAt?.timeIntervalSince1970 ?? 0.0 > $1.createdAt?.timeIntervalSince1970 ?? 0.0
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        let response = FavoriteBeers.Show.Response(beers: beers)
        presenter?.presentBeers(response: response)
    }
    
    // MARK: Fetch Filtered Beers
    
    func sortBeersAscending() {
       beers.sort(by: { $0.createdAt! > $1.createdAt!})
        let response = FavoriteBeers.Show.Response(beers: beers)
        presenter?.presentBeersAscending(response: response)
    }
    
    func sortBeersDescending() {
        beers.sort(by: { $0.createdAt! < $1.createdAt!})
        let response = FavoriteBeers.Show.Response(beers: beers)
        presenter?.presentBeersAscending(response: response)
    }
}
