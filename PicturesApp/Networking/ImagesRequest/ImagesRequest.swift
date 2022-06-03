//
//  ImagesRequest.swift
//  PicturesApp
//
//  Created by Ksusha on 03.06.2022.
//

import Foundation

protocol ImageRequestProtocl {
    func prepareParameters() -> [String:String]
    func url(params: [String:String]) -> URL?
}

final class ImageRequest: ImageRequestProtocl {
    
    static var shared: ImageRequest = {
          let instance = ImageRequest()
          return instance
    }()
 
    private init() {}
    
    func prepareParameters() -> [String : String] {
        var parametrs = [String:String]()
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(10)
        return parametrs
    }
    
    func url(params: [String : String]) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos"
        components.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
        return components.url
    }    
}
