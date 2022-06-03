//
//  PageViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import UIKit
import Accelerate

protocol PageViewControllerProtocol: AnyObject {
    func reloadPictures(models: [PictureModel])
}

final class PageViewController: UIPageViewController, PageViewControllerProtocol {
    
    private var presenter: PageViewPresenterProtocol = PageViewPresenter()
    
    private var pictureModels: [PictureModel] = []
    
    private var picturesViewControllers: [PictureViewController] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        self.delegate = self
        self.dataSource = self
        presenter.viewDidLoad()
    }
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadPictures(models: [PictureModel]) {
        pictureModels = models
        picturesViewControllers = models.map({ PictureViewController(with: $0) { [weak self] state in
            guard let scroll = self?.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else {
                return
            }
            scroll.isScrollEnabled = state
        } })
        setViewControllers([picturesViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewController = viewController as? PictureViewController,
              let index = picturesViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        let count = picturesViewControllers.count
        if count == 2, index == 0 {
            return nil
        }
        let prevIndex = (index - 1) < 0 ? count - 1 : index - 1
        return picturesViewControllers[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PictureViewController,
              let index = picturesViewControllers.firstIndex(of: viewController)
        else {
            return nil
        }
        let count = picturesViewControllers.count
        if count == 2, index == 1 {
            return nil
        }
        let nextIndex = (index + 1) >= count ? 0 : index + 1
        return picturesViewControllers[nextIndex]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pictureModels.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
    }
}
