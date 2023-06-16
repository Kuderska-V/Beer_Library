//
//  RandomInteractor.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 22.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import CoreData
import CoreLocation
import MapKit
import UIKit

protocol RandomBusinessLogic {
    func fetchRandomBeer()
    func checkButtonState()
    func isAddedToFavourites() -> Bool
    func fetchLocationPin()
    func fetchGoogleMapItem()
    func fetchLocation(request: Random.Location.Request)
}

protocol RandomDataStore {
    var beer: BeerItem? { get set }
    var isFavorite: Bool { get }
}

class RandomInteractor: NSObject, RandomBusinessLogic, RandomDataStore {
    
    var presenter: RandomPresentationLogic?
    var worker: RandomWorker?
    var beer: BeerItem?
    var isFavorite: Bool = false
    var beerApi = BeerAPI()
    var image: UIImage!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    let pin = MKPointAnnotation()
  
    // MARK: Fetch Random Beer
    
    func fetchRandomBeer() {
        beerApi.fetchRandomData(api: "https://api.punkapi.com/v2/beers/random") { [self] beer in
            self.beer = beer
            
            if isAddedToFavourites() {
                image = UIImage(systemName: "star.fill")!
            } else {
                image = UIImage(systemName: "star")!
            }
            let response = Random.ShowDetails.Response(beer: beer, isFavorite: isFavorite, image: image)
            presenter?.presentRandomBeer(response: response)
        }
    }
    
    // MARK: Favorite Status
    
    func checkButtonState() {
        if isAddedToFavourites() {
            remove()
            isFavorite = false
            print("removed")
        } else {
            save()
            isFavorite = true
            print("saved")
        }
        let response = Random.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
    
    func isAddedToFavourites() -> Bool {
        guard let beer = beer else { return false }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let email = UserDefaults.standard.value(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) as? String else { return false }
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "id == %d && owner_email = %@" , beer.id, email)
        let count = try? managedContext.count(for: fetchRequest)
        guard let count = count else { return false }
        let response = Random.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
        
        return count > 0
    }
    
    func save() {
        guard var beer = beer else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        guard let email = UserDefaults.standard.value(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) as? String else { return }
        beer.ownerEmail = email
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Beer", in: managedContext)!
        BeerItem.toManagedObject(beer: beer, entity: entity, context: managedContext)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func remove() {
        guard let beer = beer else { return }
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Beer")
        fetchRequest.predicate = NSPredicate(format: "id == %d" , beer.id)
        let beers = try? managedContext.fetch(fetchRequest)
        guard let beers = beers else { return }
        for beer in beers {
            managedContext.delete(beer)
        }
        try? managedContext.save()
    }
    
    // MARK: Location
    
    func fetchLocationPin() {
        pin.coordinate = generateRandomCoordinates(min: 10, max: 1000)
        pin.title = beer?.name
        let response = Random.Pin.Response(pin: pin)
        presenter?.presentPin(response: response)
    }
    
    func generateRandomCoordinates(min: UInt32, max: UInt32)-> CLLocationCoordinate2D {
        let currentLong = locationManager.location?.coordinate.longitude
        let currentLat = locationManager.location?.coordinate.latitude
        let meterCord = 0.00900900900901 / 1000
        let randomMeters = UInt(arc4random_uniform(max) + min)
        let randomPM = arc4random_uniform(6)
        let metersCordN = meterCord * Double(randomMeters)
        if randomPM == 0 {
            return CLLocationCoordinate2D(latitude: currentLat! + metersCordN, longitude: currentLong! + metersCordN)
        } else if randomPM == 1 {
            return CLLocationCoordinate2D(latitude: currentLat! - metersCordN, longitude: currentLong! - metersCordN)
        }else if randomPM == 2 {
            return CLLocationCoordinate2D(latitude: currentLat! + metersCordN, longitude: currentLong! - metersCordN)
        }else if randomPM == 3 {
            return CLLocationCoordinate2D(latitude: currentLat! - metersCordN, longitude: currentLong! + metersCordN)
        }else if randomPM == 4 {
            return CLLocationCoordinate2D(latitude: currentLat!, longitude: currentLong! - metersCordN)
        }else {
            return CLLocationCoordinate2D(latitude: currentLat! - metersCordN, longitude: currentLong!)
        }
    }
    
    func fetchGoogleMapItem() {
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude), addressDictionary: nil))
        mapItem.name = beer?.name
        let response = Random.MapItem.Response(mapItem: mapItem)
        presenter?.presentGoogleMapItem(response: response)
    }
}

extension RandomInteractor: CLLocationManagerDelegate {
    func fetchLocation(request: Random.Location.Request) {
        let locations = request.locations
        if !locations.isEmpty, currentLocation == nil {
            currentLocation = locations.first
            locationManager.stopUpdatingLocation()
            let lat = currentLocation?.coordinate.latitude
            let lon = currentLocation?.coordinate.longitude
            let center = CLLocationCoordinate2D(latitude: lat!, longitude: lon!)

            let response = Random.Location.Response(location: center)
            presenter?.presentLocation(response: response)
        }
    }
}
