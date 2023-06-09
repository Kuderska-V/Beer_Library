//
//  ListInteractor.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 14.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol ListBusinessLogic {
    func fetchBeers(request: List.ShowBeers.Request)
    func fetchFilteredBeers(request: List.ShowBeers.Request)
}

protocol ListDataStore {
    var filteredBeers: [BeerItem] { get }
    var isSelected: Bool { get }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    var isSelected: Bool = false
    var presenter: ListPresentationLogic?
    var beers: [BeerItem] = []
    var filteredBeers: [BeerItem] = []
    let beerApi = BeerAPI()
  
    // MARK: Fetch Beers
  
    func fetchBeers(request: List.ShowBeers.Request) {
        beerApi.fetchData(api: "https://api.punkapi.com/v2/beers/") { [self] beers in
            self.beers = beers
            self.filteredBeers = beers
            let response = List.ShowBeers.Response(beers: beers)
            presenter?.presentBeers(response: response)
        }
    }
    
    // MARK: Fetch Filtered Beers
    
    func fetchFilteredBeers(request: List.ShowBeers.Request) {
        if request.text!.isEmpty {
            isSelected = false
            filteredBeers = beers
            let response = List.ShowBeers.Response(beers: filteredBeers)
            presenter?.presentBeers(response: response)
        } else {
            isSelected = true
            filteredBeers = beers.filter { $0.name.uppercased().contains(request.text!.uppercased()) }
            let response = List.ShowBeers.Response(beers: filteredBeers)
            presenter?.presentBeers(response: response)
        }
    }
}
