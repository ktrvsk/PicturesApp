//
//  ImageController.swift
//  PicturesApp
//
//  Created by Ksusha on 16.05.2022.
//

import UIKit
import Kingfisher
import RealmSwift

protocol ImageViewControllerProtocol: AnyObject {
    func reloadTable(models: [ImageCellModel])
}

final class ImageViewController: UIViewController, ImageViewControllerProtocol{
    
    private var presenter: ImageViewPresenterProtocol = ImageViewPresenter()
    
    private var cellModels: [ImageCellModel] = []
    
    private var timer: Timer?
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ImageCell.self, forCellReuseIdentifier: ImageCell.reuseIdentifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.contentInset.top = 10
        return tableView
    }()
    
    private let searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        return searchController
    }()
    
    private var itemsForSegmentedControl = ["Pictures", "Favorites"]
    
    private lazy var segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: itemsForSegmentedControl)
        segmentedControl.addTarget(self, action: #selector(didChangeSegment(_:)), for: .valueChanged)
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        presenter.controller = self
        setupTableView()
        setupNavigationBar()
        setupSearchBar()
        setupSegmentedControl()
        presenter.viewDidLoad()
    }
    
    func reloadTable(models: [ImageCellModel]) {
        cellModels = models
        tableView.reloadData()
    }
    
    // MARK: - Setup UI Elements
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        let tittleLabel = UILabel()
        tittleLabel.text = "PICTURES"
        tittleLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        tittleLabel.textColor = .gray
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: tittleLabel)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupSegmentedControl() {
        view.addSubview(segmentedControl)
        let guide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: Constants.segmentedTrailingAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.segmentedLeadingAnchor),
            segmentedControl.topAnchor.constraint(equalTo: guide.topAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: Constants.segmendetHeightAnchor),
            tableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            tableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor)
        ])
    }
    
    @objc
    func didChangeSegment(_ segmentedControl: UISegmentedControl) {
        presenter.switchState(state: .init(rawValue: segmentedControl.selectedSegmentIndex) ?? .list)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension ImageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cellModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ImageCell.reuseIdentifier, for: indexPath) as? ImageCell else {
            return .init(frame: .zero)
        }
        return cell.update(with: cellModels[indexPath.row])
    }
}

// MARK: - UISearchBarDelegate

extension ImageViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            self.presenter.searchResults(searchTerm: searchText)
        })
    }
}

//MARK: - Constants enum

extension ImageViewController {
    private enum Constants {
        static let segmentedTrailingAnchor: CGFloat = -25
        static let segmentedLeadingAnchor: CGFloat = 25
        static let segmendetHeightAnchor: CGFloat = 35
    }
}


