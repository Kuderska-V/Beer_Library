//
//  RegistrationPresenter.swift
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

protocol RegistrationPresentationLogic {
    func presentRegisteredUser(response: Registration.User.Response)
    func presentInvalidPassword()
    func presentInvalidEmail()
    func presentPasswordConfirmationError()
}

class RegistrationPresenter: RegistrationPresentationLogic {
    weak var viewController: RegistrationDisplayLogic?
  
    // MARK: Do something
  
    func presentRegisteredUser(response: Registration.User.Response) {
        let viewModel = Registration.User.ViewModel(
            firstName: response.firstName?.uppercased(),
            lastName: response.lastName?.uppercased(),
            email: response.email,
            password: response.password,
            passwordConfirm: response.passwordConfirm,
            success: true)
        viewController?.displayRegisteredUser(viewModel: viewModel)
    }
    
    func presentInvalidPassword() {
        viewController?.showInvalidPasswordAlert()
    }
    
    func presentInvalidEmail() {
        viewController?.showInvalidEmailAlert()
    }
    
    func presentPasswordConfirmationError() {
        viewController?.showPasswordConfirmationAlert()
    }
}