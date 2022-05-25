//
//  PicturesViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import UIKit

final class PictureViewController: UIViewController {

    private var pictureImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pictureModel: PictureModel?
    
    init(with model: PictureModel) {
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        setupPicturesImageView()
        pictureModel = model
        pictureImageView.kf.setImage(with: model.image)
        
//        pictureImageView.image = pictureWith.image

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func update(with model: PictureModel) -> Self {
//        pictureModel = model
//        pictureImageView.kf.setImage(with: model.image)
//        return self
//    }
    
    private func setupPicturesImageView() {
        view.addSubview(pictureImageView)
        pictureImageView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
}
