//
//  CollectionViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation

protocol PinterestViewPresenterProtocol {
    var controller: PinterestViewController? { get set }
    func viewDidLoad()
}

final class PinterestViewPresenter: PinterestViewPresenterProtocol {
    
    weak var controller: PinterestViewController?
    
    private var models: [CollectionCellModel] = []
    
    func viewDidLoad() {
        loadData()
    }
    
    private func loadData() {
        guard let url = ImageRequest.shared.url(params: ImageRequest.shared.prepareParameters())
        else {
            return
        }
        Provider.shared.loadData(url: url, method: .GET) { [weak self] (data: [ImageModel]) in
            guard let self = self else {
                return
            }
            self.models = data.map { data in
                CollectionCellModel(image: data.urls.small, width: data.width, height: data.height)
            }
            DispatchQueue.main.async {
                self.controller?.setModels(model: self.models)
            }
        }
    }
}
