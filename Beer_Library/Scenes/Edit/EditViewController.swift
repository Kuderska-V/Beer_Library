//
//  EditViewController.swift
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

protocol EditDisplayLogic: AnyObject {
    func displayUserDetails(viewModel: Edit.User.ViewModel)
}

class EditViewController: UIViewController, EditDisplayLogic {
    var interactor: EditBusinessLogic?
    var router: (NSObjectProtocol & EditRoutingLogic & EditDataPassing)?

    // MARK: Object lifecycle
  
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
  
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
  
    // MARK: Setup
        
    private func setup() {
        let viewController = self
        let interactor = EditInteractor()
        let presenter = EditPresenter()
        let router = EditRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
  
    // MARK: Routing
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
  
    // MARK: View lifecycle
  
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUserDetails()
    }
  
    // MARK: Edit IBOutlets
  
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    func fetchUserDetails() {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let request = Edit.User.Request(firstName: firstName, lastName: lastName)
        interactor?.fetchUser(request: request)
    }
    
    func updateUserDetails() {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let request = Edit.UpdateUser.Request(firstName: firstName!, lastName: lastName!)
        interactor?.updateDetails(request: request)
    }
   
    @IBAction func tapSave(_ sender: UIButton) {
        updateUserDetails()
    }
    
    func displayUserDetails(viewModel: Edit.User.ViewModel) {
        firstNameTextField.text = viewModel.firstName
        lastNameTextField.text = viewModel.lastName
    }
}
