//
//  CollectionViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation

protocol CollectionViewPresenterProtocol {
    var controller: CollectionViewController? { get set }
    func viewDidLoad()
}

class CollectionViewPresenter: CollectionViewPresenterProtocol {
    
    weak var controller: CollectionViewController?
    
    private var models: [CollectionCellModel] = []
    
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
                self.models = data.map { data in
                    CollectionCellModel(image: data.urls.small, width: data.width, height: data.height)
                }
                self.controller?.reloadCollection(models: self.models)
            }
        }
    }

    private func prepareParametrs() -> [String:String] {
        var parametrs = [String:String]()
        parametrs["page"] = String(1)
        parametrs["per_page"] = String(30)
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
