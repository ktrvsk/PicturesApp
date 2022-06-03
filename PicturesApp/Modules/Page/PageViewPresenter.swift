//
//  PageViewPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//
import UIKit

protocol PageViewPresenterProtocol {
    var controller: PageViewControllerProtocol? { get set }
    func viewDidLoad()
}

final class PageViewPresenter: PageViewPresenterProtocol {
    
    weak var controller: PageViewControllerProtocol?
    
    private var models: [PictureModel] = []
    
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
            DispatchQueue.main.async {
                self.models = data.enumerated().map { (index, data) in
                    PictureModel(image: data.urls.small, animation: Animation.allCases[index])
                }
                self.controller?.reloadPictures(models: self.models)
            }
        }
    }
}
