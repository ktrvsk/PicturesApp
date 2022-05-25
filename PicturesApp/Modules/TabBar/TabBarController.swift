//
//  TabBarController.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import Foundation
import UIKit

protocol TabBarControllerProtocol: UIViewController {}

class TabBarController: UITabBarController, TabBarControllerProtocol {
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
            settingController(for: ImageViewController(), title: "", image: .init(systemName: "photo.on.rectangle.angled")),
            settingController(for: CollectionViewController(), title: "", image: .init(systemName: "rectangle.3.group")),
            settingController(for: GalleryViewController(), title: "", image: .init(systemName: "mail.stack") ),
            settingController(for: PageViewController(), title: "", image: .init(systemName: "ellipsis.rectangle"))
        ]
    }
}
