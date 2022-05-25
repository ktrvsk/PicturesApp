//
//  PageViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 25.05.2022.
//

import UIKit

protocol PageViewControllerProtocol: AnyObject {
    func reloadPictures(models: [PictureModel])
}

class PageViewController: UIPageViewController, PageViewControllerProtocol {
  
    private var presenter: PageViewPresenterProtocol = PageViewPresenter()
    
    var arrayPictures = [PictureModel]()
//    var pepe = UIImage(named: "pepe")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        self.delegate = self
        self.dataSource = self
        presenter.viewDidLoad()
        
//        let pepePicture = PictureModel(image: pepe)
//        arrayPictures.append(pepePicture)
    }
    
    //MARK: - create VC
//    lazy var arrayPicturesViewControllers: [PictureViewController] = {
//        var picturesVS = [PictureViewController]()
//        for picture in arrayPictures {
//            picturesVS.append(PictureViewController(with: picture))
//        }
//        return picturesVS
//    }()

    var arrayPicturesViewControllers: [PictureViewController] = []
    
    func reloadPictures(models: [PictureModel]) {
        arrayPictures = models
        arrayPicturesViewControllers = models.map({ PictureViewController(with: $0) })
        setViewControllers([arrayPicturesViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }
    
    //MARK: - init UIPageViewController
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: navigationOrientation, options: nil)
        self.view.backgroundColor = .systemBlue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PictureViewController else { return nil }
        if let index = arrayPicturesViewControllers.firstIndex(of: viewController) {
            if index > 0 {
                return arrayPicturesViewControllers[index - 1]
            }
        }
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewController = viewController as? PictureViewController else { return nil }
        if let index = arrayPicturesViewControllers.firstIndex(of: viewController) {
            if index > arrayPictures.count - 1 {
                return arrayPicturesViewControllers[index + 1]
            }
        }
        return nil
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return arrayPictures.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }
    
//    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        if !completed { return }
//        DispatchQueue.main.async() {
//            self.dataSource = nil
//            self.dataSource = self
//        }
//    }
}
