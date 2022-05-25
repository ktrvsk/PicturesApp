//
//  GalleryViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 23.05.2022.
//

import Foundation
import UIKit

protocol GalleryViewControllerProtocol {
    func reloadCollection(models: [CollectionCellModel])
}

class GalleryViewController: UIViewController, GalleryViewControllerProtocol {
    
    var constant: Int = 5
    
    var controller: GalleryViewController?
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: setupLayout())
    private var arrayCell: [CollectionCellModel] = []
    
    private var presenter: GalleryViewPresenterProtocol = GalleryViewPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        setupCollectionView()
        presenter.viewDidLoad()
    }
    
    func reloadCollection(models: [CollectionCellModel]) {
        arrayCell = models
        collectionView.reloadData()
    }
    
// MARK: - Layout Setup
    
    private func setupLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let inset: CGFloat = 2.5
            
            let largeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
            let largeItem = NSCollectionLayoutItem(layoutSize: largeItemSize)
            largeItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let smallItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.5))
            let smallItem = NSCollectionLayoutItem(layoutSize: smallItemSize)
            smallItem.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            
            let nestedGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.25), heightDimension: .fractionalHeight(1))
            let nestedGroup = NSCollectionLayoutGroup.vertical(layoutSize: nestedGroupSize, subitems: [smallItem])
            
            let outerGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(0.5))
            let outerGroup = NSCollectionLayoutGroup.horizontal(layoutSize: outerGroupSize, subitems: [largeItem, nestedGroup, nestedGroup])
            
            let section = NSCollectionLayoutSection(group: outerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: inset, leading: inset, bottom: inset, trailing: inset)
            section.orthogonalScrollingBehavior = .groupPaging
            
            return section
        }
        return layout
    }
    
// MARK: - Setup UI Elements
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.register(CollectionCell.self, forCellWithReuseIdentifier: CollectionCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.frame = view.bounds
    }
}

// MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension GalleryViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayCell.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return constant
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.identifier, for: indexPath) as? CollectionCell else {
            return .init(frame: .zero)
        }
        return cell.update(with: arrayCell[indexPath.row])
    }
}
