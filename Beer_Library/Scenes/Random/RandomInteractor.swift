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

import UIKit

protocol RandomBusinessLogic {
    func fetchRandomBeer(request: Random.ShowDetails.Request)
    func setFavoriteStatus()
}

protocol RandomDataStore {
    var beer: BeerItem? { get set }
    var isFavorite: Bool { get }
}

class RandomInteractor: RandomBusinessLogic, RandomDataStore {
    
    var presenter: RandomPresentationLogic?
    var worker: RandomWorker?
    var beer: BeerItem?
    var isFavorite: Bool = false
  
    // MARK: Fetch Random Beer
    
    func fetchRandomBeer(request: Random.ShowDetails.Request) {
        BeerAPI.shared.fetchRandomData(api: "https://api.punkapi.com/v2/beers/random") { [self] beer in
            self.beer = beer
            let response = Random.ShowDetails.Response(beer: beer)
            presenter?.presentRandomBeer(response: response)
        }
    }
    
    // MARK: Favorite Status
    
    func setFavoriteStatus() {
        isFavorite.toggle()
        let response = Random.SetFavoriteStatus.Response(isFavorite: isFavorite)
        presenter?.presentFavoriteStatus(response: response)
    }
}
