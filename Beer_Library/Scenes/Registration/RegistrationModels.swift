//
//  RegistrationModels.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 10.03.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum Registration {
  // MARK: Use cases
  
    enum User {
        struct Request {
            let firstName: String?
            let lastName: String?
            let email: String?
            let password: String?
            let passwordConfirm: String?
        }
        struct Response {
            let firstName: String?
            let lastName: String?
            let email: String?
            let password: String?
            let passwordConfirm: String?
        }
        struct ViewModel {
            let firstName: String?
            let lastName: String?
            let email: String?
            let password: String?
            let passwordConfirm: String?
            var success: Bool
        }
    }
}
