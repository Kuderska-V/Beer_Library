//
//  BeerModel.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 29.03.2023.
//

import Foundation
import CoreData

struct BeerItem: Codable {
    var id: Int
    var name: String
    var first_brewed: String
    var image_url: String
    var tagline: String
    var description: String
    var createdAt: Date?
    @CodableIgnored var ownerEmail: String?
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

