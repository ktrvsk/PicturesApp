//
//  ImageCell.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import UIKit
import Kingfisher

final class ImageCell: UITableViewCell, Reusable {
    private lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    private var pictureImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitleColor(.blue, for: .normal)
        let configuration = UIImage.SymbolConfiguration(pointSize: 30, weight: .medium, scale: .medium)
        button.setImage(SystemImage.buttonImage, for: .normal)
        button.addTarget(self, action: #selector(addButtonAction), for: UIControl.Event.touchUpInside)
        return button
    }()
    
    private var imageCellModel: ImageCellModel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        pictureImageView.image = nil
    }
    
    func update(with model: ImageCellModel) -> Self {
        imageCellModel = model
        pictureImageView.kf.setImage(with: model.image)
        label.text = model.title
        return self
    }
    
    private func setupCell() {
        setupPicturesImageView()
        setupLabel()
        setupButton()
    }
    
    private func setupLabel() {
        addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: pictureImageView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupPicturesImageView() {
        addSubview(pictureImageView)
        NSLayoutConstraint.activate([
            pictureImageView.topAnchor.constraint(equalTo: topAnchor),
            pictureImageView.heightAnchor.constraint(equalToConstant: 79),
            pictureImageView.widthAnchor.constraint(equalToConstant: 79),
            pictureImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    private func setupButton() {
        addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 25),
            button.rightAnchor.constraint(equalTo: rightAnchor, constant: -70)
        ])
    }
    
    @objc
    private func addButtonAction(button: UIButton) {
        imageCellModel?.addInFavorites()
    }
}
