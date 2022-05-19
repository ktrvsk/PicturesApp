//
//  NetworkDataFetcher.swift
//  PicturesApp
//
//  Created by Ksusha on 17.05.2022.
//

import Foundation
import Alamofire

// TODO: -> provider

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func fetchPictures(searchTerm: String, completion: @escaping (SearchData?) -> ()) {
        networkService.request(searchTerm: searchTerm) { (data, error) in
            if let error = error {
                print(error)
                completion(nil)
            }
            let decode = self.decodeJSON(type: SearchData.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else { return nil }
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let jsonError {
            print("Failed to decode JSON", jsonError)
            return nil
        }
    }
}
