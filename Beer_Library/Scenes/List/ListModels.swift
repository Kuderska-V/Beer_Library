//
//  ListModels.swift
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

enum List {
  // MARK: Use cases
  
    enum ShowBeers {
        struct Request {
            let text: String?
        }
        struct Response {
            let beers: [BeerItem]
        }
        struct ViewModel {
            struct DisplayedBeer {
                let name: String
                let year: String
                let image: String
            }
            var displayedBeers: [DisplayedBeer]
        }
    }
}
