//
//  Provider.swift
//  PicturesApp
//
//  Created by Ksusha on 12.05.2022.
//

import Foundation

protocol ProviderProtocol {
    func loadData<T: Decodable>(url: URL, completion: @escaping (T) -> Void)
}

final class Provider: ProviderProtocol {
    
    static var shared: Provider = {
          let instance = Provider()
          return instance
    }()
 
    private init() {}
    
    func loadData<T: Decodable>(url: URL, completion: @escaping (T) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard
                let saveData = data
            else {
                return
            }
            let model: T? = self?.parseJSON(saveData)
            
            guard let model = model else {
                return
            }
            completion(model)
        }
        task.resume()
    }
    
    private func parseJSON<T: Decodable>(_ urlData: Data) -> T? {
        let decoder = JSONDecoder()
        do {
            return  try decoder.decode(T.self, from: urlData)
        } catch {
            return nil
        }
    }
}
