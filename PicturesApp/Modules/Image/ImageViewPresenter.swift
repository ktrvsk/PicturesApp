//
//  ImageViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 17.05.2022.
//

import Foundation
import RealmSwift

protocol ImageViewPresenterProtocol {
    var controller: ImageViewControllerProtocol? { get set }

    func viewDidLoad()
    func searchResutls(searchTerm: String)
    func switchState(state: ImageViewState)
}

class ImageViewPresenter: ImageViewPresenterProtocol {
    
    let realm =  try! Realm() // доступ к хранилищу
    
    weak var controller: ImageViewControllerProtocol?
    
    private var models: [ImageCellModel] = []
    private var favoriteIds: [String] = []
    
    func viewDidLoad() {
//        let realm =  try! Realm() // доступ к хранилищу
//        print(Realm.Configuration.defaultConfiguration.fileURL)
//
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
            var readDatabase = try! Realm().objects(DatabaseModel.self)
            controller?.reloadTable(models: readDatabase.compactMap({ model in
                guard let url = URL(string: model.image) else {
                    return nil
                }
                return ImageCellModel(image: url, title: model.id, addInFavorites: {
                    try! self.realm.write {
                        self.realm.delete(model)
                    }
                })
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
                        let databaseModel = DatabaseModel()
                        databaseModel.image = data.urls.small.absoluteString
                        databaseModel.id = data.id
                        try! self.realm.write({
                            self.realm.add(databaseModel)
                        })
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
