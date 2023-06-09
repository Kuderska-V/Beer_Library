//
//  ProfileInteractor.swift
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

protocol ProfileBusinessLogic {
    func fetchUser(request: Profile.ShowUser.Request)
    func logoutUser()
}

protocol ProfileDataStore {
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    var presenter: ProfilePresentationLogic?
    var worker: ProfileWorker?
    let coreDataManager = CoreDataManager()

    // MARK: Fetch User
  
    func fetchUser(request: Profile.ShowUser.Request) {
        let user = coreDataManager.fetchProfileUser()
        let firstName = user.firstName
        let lastName = user.lastName
        let email = user.email
        let response = Profile.ShowUser.Response(firstName: firstName, lastName: lastName, email: email)
        presenter?.presentUser(response: response)
    }
    
    // MARK: Logout
    
    func logoutUser() {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue)
    }
}
