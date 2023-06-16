//
//  BeerModel.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 29.03.2023.
//

import CoreData
import Foundation

struct BeerItem: Codable {
    var id: Int
    var name: String
    var first_brewed: String
    var image_url: String
    var tagline: String
    var description: String
    var createdAt: Date?
    @CodableIgnored var ownerEmail: String?
    
    static func from(_ object: NSManagedObject) -> BeerItem {
        let id = object.value(forKeyPath: "id") as! Int
        let name =  object.value(forKeyPath: "name") as? String
        let year = object.value(forKeyPath: "year") as? String
        let imageURL = object.value(forKeyPath: "image") as? String
        let createdAt = object.value(forKeyPath: "created_at") as? Date
        let ownerEmail = object.value(forKeyPath: "owner_email") as? String
        return BeerItem(id: id, name: name ?? "Unknown", first_brewed: year ?? "Unknown", image_url: imageURL ?? "", tagline: "", description: "", createdAt: createdAt, ownerEmail: ownerEmail ?? "")
    }
    
    @discardableResult static func toManagedObject(beer: BeerItem, entity: NSEntityDescription, context: NSManagedObjectContext) -> NSManagedObject {
        let beerManagedObject = NSManagedObject(entity: entity, insertInto: context)
        beerManagedObject.setValue(beer.id, forKeyPath: "id")
        beerManagedObject.setValue(beer.name, forKeyPath: "name")
        beerManagedObject.setValue(beer.first_brewed, forKeyPath: "year")
        beerManagedObject.setValue(beer.image_url, forKeyPath: "image")
        beerManagedObject.setValue(Date(), forKeyPath: "created_at")
        beerManagedObject.setValue(beer.ownerEmail, forKey: "owner_email")
        return beerManagedObject
    }
}

@propertyWrapper
public struct CodableIgnored<T>: Codable {
    public var wrappedValue: T?
        
    public init(wrappedValue: T?) {
        self.wrappedValue = wrappedValue
    }
    
    public init(from decoder: Decoder) throws {
        self.wrappedValue = nil
    }
    
    public func encode(to encoder: Encoder) throws {
        // Do nothing
    }
}

extension KeyedDecodingContainer {
    public func decode<T>(
        _ type: CodableIgnored<T>.Type,
        forKey key: Self.Key) throws -> CodableIgnored<T>
    {
        return CodableIgnored(wrappedValue: nil)
    }
}

extension KeyedEncodingContainer {
    public mutating func encode<T>(
        _ value: CodableIgnored<T>,
        forKey key: KeyedEncodingContainer<K>.Key) throws
    {
        // Do nothing
    }
}

struct User {
    var email = ""
    var firstName = ""
    var lastName = ""
}
