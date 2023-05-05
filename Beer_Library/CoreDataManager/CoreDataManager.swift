//
//  Beer_LibraryCoreDataManager.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 05.04.2023.
//


import CoreData
import UIKit

protocol CoreDataManagerProtocol {
    func createUser(firstName: String, lastName: String, email: String, password: String)
    func fetchUser(email: String?, password: String?) -> Bool
    func saveUserFromSocials(email: String, firstName: String, lastName: String)
    func fetchProfileUser()
    func saveEditUser(firstName: String, lastName: String)
}

class CoreDataManager: CoreDataManagerProtocol {
    
    var userFirstName: String = ""
    var userLastName: String = ""
    var userEmail: String = ""
    
    var beers: [BeerItem] = []
    var beer: BeerItem!
    var defaults = UserDefaults.standard

    // MARK: User Operations
    
    func createUser(firstName: String, lastName: String, email: String, password: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let managedContext = appDelegate!.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as NSManagedObject
        newUser.setValue(firstName, forKey: "firstName")
        newUser.setValue(lastName, forKey: "lastName")
        newUser.setValue(email, forKey: "email")
        newUser.setValue(password, forKey: "password")
        print(newUser)
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func fetchUser(email: String?, password: String?) -> Bool {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return false }
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email!)
        
        guard let result = try? managedContext.fetch(request) else { return false }
        guard let user = result.first else { return false }
        
        let emailTexted = (user as AnyObject).value(forKey: "email") as! String
        let passwordTexted = (user as AnyObject).value(forKey: "password") as! String
        
        guard emailTexted == email else { return false }
        guard passwordTexted == password else { return false }

        return true
    }
    
    func saveUserFromSocials(email: String, firstName: String, lastName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        let newUser = NSEntityDescription.insertNewObject(forEntityName: "User", into: managedContext) as NSManagedObject
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email)
        do {
            let count = try managedContext.count(for: request)
            if(count == 0){
                newUser.setValue(firstName, forKey: "firstName")
                newUser.setValue(lastName, forKey: "lastName")
                newUser.setValue(email, forKey: "email")
                print("Got new user \(newUser)")
                try managedContext.save()
                self.defaults.set(email, forKey: UserDefaultsKeys.loggedInUserEmail.rawValue)
            } else {
                self.defaults.set(email, forKey: UserDefaultsKeys.loggedInUserEmail.rawValue)
                print("Already exist \(email)")
            }
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
        
    func fetchProfileUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let email = defaults.value(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) as? String else { return }
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email)
        do {
            guard let result = try? managedContext.fetch(request).first else { return }
            userFirstName = (result.value(forKey: "firstName") as? String)!
            userLastName = (result.value(forKey: "lastName") as? String)!
            userEmail = (result.value(forKey: "email") as? String)!
        } catch let error as NSError {
            print("Could not get user. \(error), \(error.userInfo)")
        }
    }
    
    func saveEditUser(firstName: String, lastName: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let email = defaults.value(forKey: UserDefaultsKeys.loggedInUserEmail.rawValue) as? String else { return }
        let request = NSFetchRequest<NSManagedObject>(entityName: "User")
        request.predicate = NSPredicate(format: "email = %@", email)
        do {
            let user = try managedContext.fetch(request).first
            user?.setValue(firstName, forKey: "firstName")
            user?.setValue(lastName, forKey: "lastName")
            do {
                try managedContext.save()
            } catch let error as NSError {
                print("Could not update user. \(error), \(error.userInfo)")
            }
        } catch let error as NSError {
            print("Could not get user. \(error), \(error.userInfo)")
        }
    }
    
}
