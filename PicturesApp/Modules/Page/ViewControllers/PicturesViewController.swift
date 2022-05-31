//
//  PicturesViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import UIKit

class PictureViewController: UIViewController {
    
    //MARK: - Drawing variables
    var lastPoint = CGPoint.zero
    var brushWidth: CGFloat = 10.0
    var opacity: CGFloat = 1.0
    var swiped = false
    
    var index: Int = 0
    
    var pictureImageView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var pictureModel: PictureModel?
    private let onChangeScrollState: (Bool) -> Void
    
    init(with model: PictureModel, onChangeScrollState: @escaping (Bool) -> Void) {
        self.onChangeScrollState = onChangeScrollState
        super.init(nibName: nil, bundle: nil)
        edgesForExtendedLayout = []
        setupPicturesImageView()
        pictureModel = model
        pictureImageView.kf.setImage(with: model.image)
        
        //setup animation
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAnimation)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupPicturesImageView() {
        view.addSubview(pictureImageView)
        NSLayoutConstraint.activate([
            pictureImageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            pictureImageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            pictureImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pictureImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    @objc
    func tapAnimation() {
        pictureModel?.animation.startAnimation(view: pictureImageView)
    }
    
    //MARK: - Setup drawing
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChangeScrollState(false)
        
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLineFrom(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(view.frame.size)
        let context = UIGraphicsGetCurrentContext()
        pictureImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height))
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(brushWidth)
        context?.setBlendMode(CGBlendMode.normal)
        
        context?.strokePath()
        
        pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        pictureImageView.alpha = opacity
        UIGraphicsEndImageContext()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            let currentPoint = touch.location(in: view)
            drawLineFrom(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        onChangeScrollState(true)
        
        if !swiped {
            drawLineFrom(fromPoint: lastPoint, toPoint: lastPoint)
        }
        
        UIGraphicsBeginImageContext(view.frame.size)
        pictureImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: 1.0)
        pictureImageView.image?.draw(in: CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height), blendMode: CGBlendMode.normal, alpha: opacity)
        pictureImageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
