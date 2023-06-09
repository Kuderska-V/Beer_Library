//
//  EditInteractor.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 26.04.2023.
//  Copyright (c) 2023 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol EditBusinessLogic {
    func fetchUser(request: Edit.User.Request)
    func updateDetails(request: Edit.UpdateUser.Request)
}

protocol EditDataStore {
}

class EditInteractor: EditBusinessLogic, EditDataStore {
    var presenter: EditPresentationLogic?
    var worker: EditWorker?
    let coreDataManager = CoreDataManager()
  
    // MARK: Fetch User Details
  
    func fetchUser(request: Edit.User.Request) {
        let user = coreDataManager.fetchProfileUser()
        let firstName = user.firstName
        let lastName = user.lastName
        let response = Edit.User.Response(firstName: firstName, lastName: lastName)
        presenter?.presentUserDetails(response: response)
    }
    
    func updateDetails(request: Edit.UpdateUser.Request) {
        let firstName = request.firstName
        let lastName = request.lastName
        coreDataManager.saveEditUser(firstName: firstName, lastName: lastName)
        let response = Edit.User.Response(firstName: firstName, lastName: lastName)
        presenter?.presentUserDetails(response: response)
    }
}
