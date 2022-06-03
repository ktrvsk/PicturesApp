//
//  Provider.swift
//  PicturesApp
//
//  Created by Ksusha on 12.05.2022.
//

import Foundation

protocol ProviderProtocol {
    func loadData<T: Decodable>(url: URL, method: HttpMethod, completion: @escaping (T) -> Void)
}

final class Provider: ProviderProtocol {
    
    static var shared: Provider = {
          let instance = Provider()
          return instance
    }()
 
    private init() {}
    
    func loadData<T: Decodable>(url: URL, method: HttpMethod, completion: @escaping (T) -> Void) {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = prepareHeader()
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] (data, response, error) in
            
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
    
    private func prepareHeader() -> [String:String]? {
        var headers = [String:String]()
        headers["Authorization"] = "Client-ID \(ConstantsNetworking.accessKey ?? "")"
        return headers
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
