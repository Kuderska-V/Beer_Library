//
//  General Routes.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 22.03.2023.
//

import Foundation

enum Storyboards: String {
    case registration = "Registration"
    case login = "Login"
    case tabBar = "TabBar"
    case list = "List"
    case random = "Random"
    case profile = "Profile"
    case detail = "Detail"
}

enum ViewControllers: String {
    case registration = "RegistrationVC"
    case login = "LoginVC"
    case tabBar = "TabBar"
    case list = "ListVC"
    case random = "RandomVC"
    case profile = "ProfileVC"
    case detail = "DetailVC"
}

enum UserDefaultsKeys: String {
    case loggedInUserEmail = "loggedInUserEmail"
}

enum AlertController: String {
    case fieldsEmpty = "Please, fill all the required fields"
    case invalidEmail = "Email is invalid"
    case invalidPassword = "Password must contain at least 5 characters, including numbers"
    case matchPasswords = "Passwords do not match"
    case incorrectPassword = "Email or password is incorrect"
    case userNotFound = "User not found"
    case somethingWentWrong = "Something went wrong"
}
