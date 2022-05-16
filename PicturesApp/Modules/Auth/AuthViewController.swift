//
//  AuthViewController.swift
//  PicturesApp
//
//  Created by Ksusha on 11.05.2022.
//

import UIKit
import WebKit

protocol AuthViewControllerProtocol: AnyObject {
    func loadRequest(_ request: URLRequest)
    func showLoader()
    func openNext()
}

class AuthViewController: UIViewController, AuthViewControllerProtocol {
    
    @IBOutlet private var webView: WKWebView!
    @IBOutlet private var loaderView: UIView!
    @IBOutlet private var activityView: UIActivityIndicatorView!
    
    private let presenter: AuthPresenterProtocol = AuthPresenter()

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        presenter.controller = self
        presenter.viewDidLoad()
    }
    
    func loadRequest(_ request: URLRequest) {
        webView.load(request)
    }
    
    func showLoader() {
        loaderView.isHidden = false
        activityView.startAnimating()
    }
    
    func openNext() {
        let tabBar: TabBarControllerProtocol = TabBarController()
        navigationController?.setViewControllers([tabBar], animated: true)
    }
}

extension AuthViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        guard
            let currentURL = webView.url?.absoluteString,
            let code = getQueryStringParameter(url: currentURL, param: "code")
        else {
            return
        }
        presenter.getToken(with: code)
    }
    
    private func getQueryStringParameter(url: String, param: String) -> String? {
        guard let url = URLComponents(string: url) else { return nil }
        return url.queryItems?.first(where: { $0.name == param })?.value
    }
}
