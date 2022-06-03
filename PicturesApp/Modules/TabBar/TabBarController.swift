//
//  TabBarController.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import Foundation
import UIKit

protocol TabBarControllerProtocol: UIViewController {}

final class TabBarController: UITabBarController, TabBarControllerProtocol {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    private func settingController(for rootController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
    
    private func setupTabBar() {
        viewControllers = [
            settingController(for: ImageViewController(), title: "", image: SystemImage.firstScreenTabBar),
            settingController(for: PinterestViewController(), title: "", image: SystemImage.secondScreenTabBar),
            settingController(for: GalleryViewController(), title: "", image: SystemImage.thirdScreenTabBar),
            settingController(for: PageViewController(), title: "", image: SystemImage.fourthScreenTabBar)
        ]
    }
}
