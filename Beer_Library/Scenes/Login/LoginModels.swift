//
//  LoginModels.swift
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

enum Login {
    // MARK: Use cases
  
    enum User {
        struct Request {
            let email: String?
            let password: String?
        }
        struct Response {
            let email: String?
            let password: String?
        }
        struct ViewModel {
            let email: String?
            let password: String?
        }
    }
    
    enum Socials {
        struct Request {
            let firstName: String?
            let lastName: String?
            let email: String?
        }
    }
}
