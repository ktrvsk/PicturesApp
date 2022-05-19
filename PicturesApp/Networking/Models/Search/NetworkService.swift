//
//  NetworkService.swift
//  PicturesApp
//
//  Created by Ksusha on 17.05.2022.
//

import Foundation

// TODO: -> ImageViewPresenter

class NetworkService {
    
    func request(searchTerm: String, completion: @escaping (Data?, Error?) -> Void) {
        
        let parametrs = self.prepareParametrs(searchTerm: searchTerm)
        let url = self.url(params: parametrs)
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = prepareHeader()
        request.httpMethod = "GET"
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func prepareHeader() -> [String:String]? {
        var headers = [String:String]()
        headers["Authorization"] = "Client-ID 2XIGRAqt8KnYCEcP7bQ39J9Feakzz8SPL8Ognu-lGOw"
        return headers
    }

    private func prepareParametrs(searchTerm: String?) -> [String:String] {
        var parametrs = [String:String]()
        parametrs["query"] = searchTerm
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(30)
        return parametrs
    }
    
    private func url(params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/search/photos"
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
    
    
    // TODO:  -> provider 
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
