//
//  CollectionCell.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation
import UIKit
import SnapKit


class CollectionCell: UICollectionViewCell {
    
    static let identifier = "CollectionCell"
    
    private let pictureCollectionView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private var collectionCellModel: CollectionCellModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPicturesImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPicturesImageView() {
        addSubview(pictureCollectionView)
        pictureCollectionView.translatesAutoresizingMaskIntoConstraints = false
        pictureCollectionView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureCollectionView.image = nil
    }
    
    func update(with model: CollectionCellModel) -> Self {
        collectionCellModel = model
        pictureCollectionView.kf.setImage(with: model.image)
        return self
    }
}
