//
//  Beer_LibraryCoreDataManager.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 05.04.2023.
//


import CoreData
import UIKit

class CoreDataManager {
    
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
    
    
}
