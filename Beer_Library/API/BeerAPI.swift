//
//  BeerAPI.swift
//  Beer_Library
//
//  Created by Vitalina Nazaruk on 31.03.2023.
//

import Foundation

class BeerAPI {
    
    func fetchData(api: String, completion: @escaping (_ beers: [BeerItem]) -> Void) {
        guard let url = URL(string: api) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let beers = try decoder.decode([BeerItem].self, from: data)
                DispatchQueue.main.async {
                    completion(beers)
                    
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
    }
    
    func fetchRandomData(api: String, completion: @escaping (_ beers: BeerItem?) -> Void) {
        guard let url = URL(string: api) else { return }
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let beers = try decoder.decode([BeerItem].self, from: data)
                DispatchQueue.main.async {
                    completion(beers.first)
                }
            } catch let error {
                print("Error serialization json", error)
            }
        }
        task.resume()
    }
}



