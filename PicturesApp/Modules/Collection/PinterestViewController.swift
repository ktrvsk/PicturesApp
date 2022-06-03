//
//  CollectionViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation
import UIKit

protocol PinterestViewControllerProtocol {
    func setModels(model: [CollectionCellModel])
}

class PinterestViewController: UIViewController, PinterestViewControllerProtocol {
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.reuseIdentifier)
//        collection.autoresizingMask = 
        return collection
    }()
    
    private var cellModels: [CollectionCellModel] = []
    
    private var presenter: PinterestViewPresenterProtocol = PinterestViewPresenter()
    
    private var layout = PinterestLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        layout.delegate = self
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    func setModels(model: [CollectionCellModel]) {
        cellModels = model
        collectionView.reloadData()
    }
    
// MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension PinterestViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reuseIdentifier, for: indexPath) as? CollectionCell else {
            return .init(frame: .zero)
        }
        return cell.update(with: cellModels[indexPath.row])
    }
}

// MARK: - PinterestLayoutDelegate

extension PinterestViewController: PinterestLayoutDelegate {
    func collectionView(_ collection: UICollectionView, sizeOfPhotoAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cellModels[indexPath.row].width, height: cellModels[indexPath.row].height)
    }
}
