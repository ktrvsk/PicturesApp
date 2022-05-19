//
//  ImageCell.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import UIKit
import Kingfisher

class ImageCell: UITableViewCell {
    
    private let label = UILabel(frame: .zero)
    
//    private let checkmark: UIImageView = {
//        let image = UIImage(named: "check")
//        let imageView = UIImageView(image: image)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.alpha = 0
//        return imageView
//    }()
    
    private let pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupPicturesImageView()
        setupLabel()
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupLabel() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupPicturesImageView() {
        addSubview(pictureImageView)
        pictureImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: topAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 79),
            pictureImageView.widthAnchor.constraint(equalToConstant: 79),
            pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

//    private func setupCheckmarkView() {
//        addSubview(checkmark)
//        checkmark.trailingAnchor.constraint(equalTo: pictureImageView.trailingAnchor, constant: -8).isActive = true
//        checkmark.bottomAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: -8).isActive = true
//    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    func update(with model: ImageCellModel) -> Self {
        pictureImageView.kf.setImage(with: model.image)
        label.text = model.title
        return self
    }
}
