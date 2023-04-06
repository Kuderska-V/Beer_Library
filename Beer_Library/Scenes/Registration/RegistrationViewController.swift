//
//  RegistrationViewController.swift
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

protocol RegistrationDisplayLogic: AnyObject {
    func displayRegisteredUser(viewModel: Registration.User.ViewModel)
    func showInvalidPasswordAlert()
    func showInvalidEmailAlert()
    func showPasswordConfirmationAlert()
}

class RegistrationViewController: UIViewController, RegistrationDisplayLogic, UITextFieldDelegate {

    var interactor: RegistrationBusinessLogic?
    var router: (NSObjectProtocol & RegistrationRoutingLogic & RegistrationDataPassing)?

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
        let interactor = RegistrationInteractor()
        let presenter = RegistrationPresenter()
        let router = RegistrationRouter()
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
        navigationItem.hidesBackButton = true
        firstNameTextField.delegate = self
        lastNameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
        passwordConfirmTextField.delegate = self
    }
  
    // MARK: Registration IBOutlets & IBActions
  
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordConfirmTextField: UITextField!
    
    @IBAction func pressSignUp(_ sender: UIButton) {
        if areSomeFieldsEmpty() {
            self.showAlertMessage(message: AlertController.fieldsEmpty.rawValue)
            return
        }
        registerNewUser()
    }
    
    // MARK: Fetch Registration
  
    func registerNewUser() {
        let firstName = firstNameTextField.text
        let lastName = lastNameTextField.text
        let email = emailTextField.text
        let password = passwordTextField.text
        let passwordConfirm = passwordConfirmTextField.text
        
        let request = Registration.User.Request(firstName: firstName, lastName: lastName, email: email, password: password, passwordConfirm: passwordConfirm)
        interactor?.registerNewUser(request: request)
    }
  
    func displayRegisteredUser(viewModel: Registration.User.ViewModel) {
        if viewModel.success == true {
            router?.routeToTabBar(segue: nil)
        } else {
            self.showAlertMessage(message: AlertController.fieldsEmpty.rawValue)
        }
    }
    
    func showInvalidPasswordAlert() {
        self.showAlertMessage(message: AlertController.invalidPassword.rawValue)
    }
    
    func showInvalidEmailAlert() {
        self.showAlertMessage(message: AlertController.invalidEmail.rawValue)
    }
    
    func showPasswordConfirmationAlert() {
        self.showAlertMessage(message: AlertController.matchPasswords.rawValue)
    }
    
    private func areSomeFieldsEmpty() -> Bool {
        firstNameTextField.text!.isEmpty || lastNameTextField.text!.isEmpty || emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty || passwordConfirmTextField.text!.isEmpty
    }
}
