//
//  StoreItemController.swift
//  iTunesSearch
//
//  Created by MOJO on 2024/6/7.
//

import Foundation
import UIKit

class StoreItemController {
    
    static let shared = StoreItemController()
    
    func fetchItems(term: String, completion: @escaping ([StoreModel]?) -> Void) {
        
        let url = URL(string: "https://itunes.apple.com/search?term=\(term)")
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else if let data = data {
                print(String(data: data, encoding: .utf8)!)
                do {
                    let decoder = JSONDecoder()
                    let searchResponse = try decoder.decode(SearchResponse.self, from: data)
                    completion(searchResponse.results)
                } catch {
                    print(error)
                    completion(nil)
                }
            }
        }
        task.resume()
    }
    
    func fetchImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completion(nil)
            } else if let data = data, let image = UIImage(data: data) {
                completion(image)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
