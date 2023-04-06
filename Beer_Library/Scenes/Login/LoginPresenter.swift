//
//  LoginPresenter.swift
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

protocol LoginPresentationLogic {
    func presentLogin(response: Login.User.Response)
    func presentIncorrectPassword()
}

class LoginPresenter: LoginPresentationLogic {
    weak var viewController: LoginDisplayLogic?

    // MARK: Do something

    func presentLogin(response: Login.User.Response) {
        let viewModel = Login.User.ViewModel(email: response.email, password: response.password, success: true)
        if viewModel.success == true {
            viewController?.displayLogin(viewModel: viewModel)
        } else {
            return
        }
    }
    
    func presentIncorrectPassword() {
        viewController?.showIncorrectPasswordAlert()
    }
}
