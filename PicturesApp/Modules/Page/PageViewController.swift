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

class PageViewController: UIPageViewController, PageViewControllerProtocol {

    private var presenter: PageViewPresenterProtocol = PageViewPresenter()
    
    var arrayPictures = [PictureModel]()

    var arrayPicturesViewControllers: [PictureViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        self.delegate = self
        self.dataSource = self
        presenter.viewDidLoad()
    }
    
    func reloadPictures(models: [PictureModel]) {
        arrayPictures = models
        arrayPicturesViewControllers = models.map({ PictureViewController(with: $0) { [weak self] state in
            guard let scroll = self?.view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else {
                return
            }
            scroll.isScrollEnabled = state
        } })
        setViewControllers([arrayPicturesViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PictureViewController,
              let index = arrayPicturesViewControllers.firstIndex(of: viewController) else { return nil }
            let count = arrayPicturesViewControllers.count
            if count == 2, index == 0 {
                return nil
            }
            let prevIndex = (index - 1) < 0 ? count - 1 : index - 1
            let pageContentViewController: UIViewController = arrayPicturesViewControllers[prevIndex]
            return pageContentViewController
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PictureViewController,
                let index = arrayPicturesViewControllers.firstIndex(of: viewController) else { return nil }
                let count = arrayPicturesViewControllers.count
                if count == 2, index == 1 {
                    return nil
                }
                let nextIndex = (index + 1) >= count ? 0 : index + 1
                let pageContentViewController = arrayPicturesViewControllers[nextIndex]
                return pageContentViewController
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayPictures.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
}
