//
//  ImageViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 17.05.2022.
//

import Foundation

protocol ImageViewPresenterProtocol {
    var controller: ImageViewControllerProtocol? { get set }

    func viewDidLoad()
    func searchResutls(searchTerm: String)
    func switchState(state: ImageViewState)
}

class ImageViewPresenter: ImageViewPresenterProtocol {    
    
    weak var controller: ImageViewControllerProtocol?
    
    private var models: [ImageCellModel] = []
    private var favoriteIds: [String] = []
    
    func viewDidLoad() {
        loadData()
    }
    
    func searchResutls(searchTerm: String) {
        controller?.reloadTable(models: models.filter{ model in
            model.title.hasPrefix(searchTerm)
        })
    }
    
    func switchState(state: ImageViewState) {
        switch state {
        case .list:
            controller?.reloadTable(models: models)
        case .favorites:
            controller?.reloadTable(models: models.filter({ model in
                favoriteIds.contains(model.title)
            }))
        }
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
                    ImageCellModel(image: data.urls.small, title: data.id) {
                        self.favoriteIds.append(data.id)
                    }
                }
                self.controller?.reloadTable(models: self.models)
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
