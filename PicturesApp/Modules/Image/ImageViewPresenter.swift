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
    func searchResults(searchTerm: String)
    func switchState(state: ImageViewState)
}

final class ImageViewPresenter: ImageViewPresenterProtocol {
    
    weak var controller: ImageViewControllerProtocol?
    
    private var models: [ImageCellModel] = []
    
    func viewDidLoad() {
        loadData()
    }
    
    func searchResults(searchTerm: String) {
        controller?.reloadTable(models: models.filter{ model in
            model.title.hasPrefix(searchTerm)
        })
    }
    
    func switchState(state: ImageViewState) {
        switch state {
        case .list:
            controller?.reloadTable(models: models)
        case .favorites:
            let result: Results<ImageDatabaseModel>? = RealmDataBase.shared.read()
            controller?.reloadTable(models: result?.compactMap({ model in
                guard let url = URL(string: model.image) else {
                    return nil
                }
                return ImageCellModel(image: url, title: model.id, addInFavorites: {
                    RealmDataBase.shared.write {
                        RealmDataBase.shared.delete(model)
                    }
                })
            }) ?? [])
        }
    }
    
    private func loadData() {
        guard
            let url = ImageRequest.shared.url(params: ImageRequest.shared.prepareParameters())
        else {
            return
        }
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: [ImageModel]) in
            guard let self = self else {
                return
            }
            self.models = data.map { data in
                ImageCellModel(image: data.urls.small, title: data.id) {
                    let databaseModel = ImageDatabaseModel()
                    databaseModel.image = data.urls.small.absoluteString
                    databaseModel.id = data.id
                    RealmDataBase.shared.write {
                        RealmDataBase.shared.add(databaseModel)
                    }
                }
            }
            DispatchQueue.main.async {
                self.controller?.reloadTable(models: self.models)
            }
        }
    }
}
