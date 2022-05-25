//
//  CollectionViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation
import UIKit

protocol CollectionViewControllerProtocol {
    func reloadCollection(models: [CollectionCellModel])
}

class CollectionViewController: UIViewController, CollectionViewControllerProtocol {
    var controller: CollectionViewController?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    private var arrayCell: [CollectionCellModel] = []
    
    private var presenter: CollectionViewPresenterProtocol = CollectionViewPresenter()
    
    private lazy var layout = PinterestLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        layout.delegate = self
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    func reloadCollection(models: [CollectionCellModel]) {
        arrayCell = models
        collectionView.reloadData()
    }
    
// MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
        collectionView.frame = view.bounds
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension CollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return .init(frame: .zero)
        }
//        cell.backgroundColor = .blue
        return cell.update(with: arrayCell[indexPath.row])
    }
}

// MARK: - PinterestLayoutDelegate

extension CollectionViewController: PinterestLayoutDelegate {
    func collectionView(_ collection: UICollectionView, sizeOfPhotoAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: arrayCell[indexPath.row].width, height: arrayCell[indexPath.row].height)
    }
}
