//
//  ImageController.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import UIKit
import Kingfisher

protocol ImageViewControllerProtocol: AnyObject {
    func reloadTable(models: [ImageCellModel])
}

class ImageViewController: UIViewController, ImageViewControllerProtocol {
    
    private var presenter: ImageViewPresenterProtocol = ImageViewPresenter()
    private var timer: Timer?
    
    private let tableView = UITableView()
    private var arrayCell: [ImageCellModel] = []
    
    private let searchController = UISearchController(searchResultsController: nil)
    
    private var arrayItemsForSegmented = ["Pictures", "Favorites"]
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: arrayItemsForSegmented)
//        segmentedControl.addTarget(self, action: #selector(suitDidChange(_:)), for: .valueChanged)
        return segmentedControl
    }()
    
    private lazy var addBarButtonItem: UIBarButtonItem = {
        return UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addBarButtonTap))
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.controller = self
        view.backgroundColor = .white
//        searchController.searchBar.delegate = self
        setupTableView()
        setupNavigationBar()
//        setupSearchBar()
        setupSegmentedControl()
        presenter.viewDidLoad()
    }
    
    func reloadTable(models: [ImageCellModel]) {
        arrayCell = models
        tableView.reloadData()
    }
    
    // MARK: - NavigationItems action

    @objc private func addBarButtonTap() {
        print(#function)
    }
    
    // MARK: - Setup UI Elements
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.register(ImageCell.self, forCellReuseIdentifier: "ImageCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.separatorStyle = .none
        tableView.contentInset.top = 10
    }

    private func setupNavigationBar()
    {
        let tittleLabel = UILabel()
        tittleLabel.text = "PICTURES"
        tittleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tittleLabel.textColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: tittleLabel)
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.rightBarButtonItem = addBarButtonItem
    }
    
    private func setupSearchBar(){
        navigationItem.searchController = searchController
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
//        view.layoutSubviews()
//        view.layoutIfNeeded()
    }
    
    func setupSegmentedControl(){
        view.addSubview(segmentedControl)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            segmentedControl.topAnchor.constraint(equalTo: guide.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
//  @objc func suitDidChange(_ segmentedControl: UISegmentedControl) {
//        switch segmentedControl.selectedSegmentIndex {
//        case 0:
//            self.tableView.backgroundColor=UIColor.purple
//        case 1:
//            self.tableView.backgroundColor=UIColor.yellow
//        default:
//            self.view.backgroundColor=UIColor.gray
//        }
//    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        arrayCell.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as? ImageCell else {
            return .init(frame: .zero)
        }
        return cell.update(with: arrayCell[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate

//extension ImageViewController: UISearchBarDelegate {
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(searchText)
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
//            self.networkDataFetcher.fetchPictures(searchTerm: searchText) { (searchResults) in
//                searchResults?.results.map({ (picture) in
//                    print(picture.urls["small"])
//                })
//            }
//        })
//    }
//}
