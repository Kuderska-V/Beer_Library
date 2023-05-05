//
//  DetailModels.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 30.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit
import MapKit

enum Detail {
    
  // MARK: Use cases
    enum ShowDetail {
        struct Request {
        }
        struct Response {
            let beer: BeerItem?
            var isFavorite: Bool
            var image: UIImage
        }
        struct ViewModel {
            var name: String
            var first_brewed: String
            var image_url: String
            var isFavorite: Bool
            var image: UIImage
        }
    }
    
    enum SetFavoriteStatus {
        struct Request {
        }
        struct Response {
            var isFavorite: Bool
        }
        struct ViewModel {
            var isFavorite: Bool
        }
    }
    
    enum Details {
        struct Response {
            var tagline: String
            var description: String
        }
        struct ViewModel {
            var tagline: String
            var description: String
        }
    }
    
    enum Location {
        struct Request {
            var locations: [CLLocation]
        }
        struct Response {
            var location: CLLocationCoordinate2D
        }
        struct ViewModel {
            var location: CLLocationCoordinate2D
        }
    }
    
    enum Pin {
        struct Response {
            var pin: MKPointAnnotation?
        }
        struct ViewModel {
            var pin: MKPointAnnotation?
        }
    }
    
    enum MapItem {
        struct Response {
            var mapItem: MKMapItem?
        }
        struct ViewModel {
            var mapItem: MKMapItem?
        }
    }
}
