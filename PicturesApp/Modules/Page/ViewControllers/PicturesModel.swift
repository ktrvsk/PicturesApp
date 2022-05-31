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
    func startAnimation(view: UIView) {
        switch self {
        case .animationZero:
            zeroAnimation(view: view)
        case .animationFirst:
            firstAnimation(view: view)
        case .animationSecond:
            secondAnimation(view: view)
        case .animationThird:
            thirdAnimation(view: view)
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
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            view.transform = CGAffineTransform(translationX: -30, y: 0)
        } completion: { (_) in
            UIView.animate(withDuration: 0.5, delay: 0 , usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.alpha = 0
                view.transform = view.transform.translatedBy(x: 0, y: -200)
            })
        }
    }
    
    private func firstAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            if let imageView = view as? UIImageView {
                imageView.image = UIImage(named: "pepeTwo")
            }
            view.layer.borderWidth = 5
            view.layer.borderColor = UIColor.blue.cgColor
        }
    }
    
    private func secondAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            let textLayer = CATextLayer()
            view.layer.addSublayer(textLayer)
            textLayer.frame = view.frame
            textLayer.string = "Image"
            textLayer.alignmentMode = .center
            textLayer.font = CTFontCreateWithName("Noteworthy-Light" as CFString, CGFloat(24.0), nil)
        }
    }
    
    private func thirdAnimation(view: UIView) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
            print("hello")
        }
    }
    
//    private func fourthAnimation(view: UIView) {
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut) {
//
//        }
//    }
}

