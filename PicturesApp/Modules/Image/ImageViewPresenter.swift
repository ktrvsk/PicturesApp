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
}

class ImageViewPresenter: ImageViewPresenterProtocol {    
    
    weak var controller: ImageViewControllerProtocol?
    
    func viewDidLoad() {
        loadData()
    }
    
    private func loadData() {
        let parametrs = prepareParametrs()
        let url = url(params: parametrs)
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: [ImageData]) in
            DispatchQueue.main.async {
                self!.controller?.reloadTable(models: data.map { data in
                    ImageCellModel(image: data.urls.small, title: data.id)
                })
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
