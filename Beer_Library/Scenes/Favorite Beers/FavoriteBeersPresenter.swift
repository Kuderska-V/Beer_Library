//
//  FavoriteBeersPresenter.swift
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

protocol FavoriteBeersPresentationLogic {
    func presentBeers(response: FavoriteBeers.Show.Response)
    func presentBeersAscending(response: FavoriteBeers.Show.Response)
    func presentBeersDescending(response: FavoriteBeers.Show.Response)
}

class FavoriteBeersPresenter: FavoriteBeersPresentationLogic {
    weak var viewController: FavoriteBeersDisplayLogic?
  
    // MARK: Present Beers
  
    func presentBeers(response: FavoriteBeers.Show.Response) {
        let displayedBeers = convertBeers(beers: response.beers)
        let viewModel = FavoriteBeers.Show.ViewModel(displayedBeers: displayedBeers)
        viewController?.displayFavoriteBeers(viewModel: viewModel)
    }
    
    private func convertBeers(beers: [BeerItem]) -> [FavoriteBeers.Show.ViewModel.DisplayedBeer] {
        return beers.map { FavoriteBeers.Show.ViewModel.DisplayedBeer(name: $0.name, year: $0.first_brewed, image: $0.image_url) }
    }
    
    // MARK: Present Filtered Beers
    
    func presentBeersAscending(response: FavoriteBeers.Show.Response) {
        let displayedBeers = convertBeers(beers: response.beers)
        let viewModel = FavoriteBeers.Show.ViewModel(displayedBeers: displayedBeers)
        viewController?.displayBeersAscending(viewModel: viewModel)
    }
    
    func presentBeersDescending(response: FavoriteBeers.Show.Response) {
        let displayedBeers = convertBeers(beers: response.beers)
        let viewModel = FavoriteBeers.Show.ViewModel(displayedBeers: displayedBeers)
        viewController?.displayBeersDescending(viewModel: viewModel)
    }
}
