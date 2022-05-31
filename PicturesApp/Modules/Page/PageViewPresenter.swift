//
//  PageViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import Foundation
import UIKit

import Foundation

protocol PageViewPresenterProtocol {
    var controller: PageViewControllerProtocol? { get set }
    func viewDidLoad()
}

class PageViewPresenter: PageViewPresenterProtocol {
    
    weak var controller: PageViewControllerProtocol?
    
    private var models: [PictureModel] = []
    
    func viewDidLoad() {
        loadData()
    }

    private func loadData() {
        let parametrs = prepareParametrs()
        let url = url(params: parametrs)
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: [ImageData]) in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.models = data.enumerated().map { (index, data) in
                    PictureModel(image: data.urls.small, animation: Animation.allCases[index])
                }
                self.controller?.reloadPictures(models: self.models)
            }
        }
    }

    private func prepareParametrs() -> [String:String] {
        var parametrs = [String:String]()
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(10)
        return parametrs
    }
    
    private func url(params: [String:String]) -> URL {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        components.path = "/photos"
        components.queryItems = params.map {URLQueryItem(name: $0, value: $1)}
        return components.url!
    }
}
