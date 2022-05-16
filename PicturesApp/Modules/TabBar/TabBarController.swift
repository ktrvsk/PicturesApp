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
        
//        tabBar
        
        viewControllers = [
            settingController(for: ViewController(), title: "first", image: .init(named: "cloud"))
        ] //запихнуть все созданные экраны
    }
    
    // настройка экрана по отдельность
    private func settingController(for rootController: UIViewController, title: String, image: UIImage?) -> UIViewController {
        let navigationController = UINavigationController(rootViewController: rootController)
        navigationController.tabBarItem.title = title
        navigationController.tabBarItem.image = image
        return navigationController
    }
}
