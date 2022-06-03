//
//  PicturesModel.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import Foundation
import UIKit

struct PictureModel {
    let image: URL
    let animation: Animation
}

enum Animation: CaseIterable {
    case animationZero 
    case animationFirst
    case animationSecond
    case animationThird
    case animationFourth
    case animationFiveth
    case animationSixth
    case animationSeventh
    case animationEighth
    case animationNinth
}

extension Animation {
    
    enum Constants {
        static let duration = 0.5
        static let delay = 0.0
        static let usingSpringWithDamping = 0.5
        static let initialSpringVelocity = 0.5
        static let options = UIView.AnimationOptions.curveEaseOut
    }
    
    func startAnimation(view: UIView) {
        switch self {
        case .animationZero:
            zeroAnimation(view: view)
        case .animationFirst:
            firstAnimation(view: view)
        case .animationSecond:
            secondAnimation(view: view)
        case .animationThird:
            print("here")
        case .animationFourth:
            print("here")
        case .animationFiveth:
            print("here")
        case .animationSixth:
            print("here")
        case .animationSeventh:
            print("here")
        case .animationEighth:
            print("here")
        case .animationNinth:
            print("here")
        }
    }
    
    private func zeroAnimation(view: UIView) {
        UIView.animate(withDuration: Constants.duration, delay: Constants.delay, usingSpringWithDamping: Constants.usingSpringWithDamping, initialSpringVelocity: Constants.initialSpringVelocity, options: Constants.options) {
            view.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { (_) in
            UIView.animate(withDuration: Constants.duration, delay: Constants.delay, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: Constants.options, animations: {
                view.alpha = 0
                view.transform = view.transform.translatedBy(x: 0, y: -200)
            })
        }
    }
    
    private func firstAnimation(view: UIView) {
        UIView.animate(withDuration: Constants.duration, delay: Constants.delay, usingSpringWithDamping: Constants.usingSpringWithDamping, initialSpringVelocity: Constants.initialSpringVelocity, options: Constants.options) {
            if let imageView = view as? UIImageView {
                imageView.image = SystemImage.imageForAnimation
            }
            view.layer.borderWidth = 5
            view.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    private func secondAnimation(view: UIView) {
        UIView.animate(withDuration: Constants.duration, delay: Constants.delay, usingSpringWithDamping: Constants.usingSpringWithDamping, initialSpringVelocity: Constants.initialSpringVelocity, options: Constants.options) {
            let textLayer = CATextLayer()
            view.layer.addSublayer(textLayer)
            textLayer.frame = view.frame
            textLayer.string = "Image"
            textLayer.alignmentMode = .center
            textLayer.font = CTFontCreateWithName("Noteworthy-Light" as CFString, CGFloat(24.0), nil)
        }
    }
}

