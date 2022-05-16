//
//  AuthPresenter.swift
//  PicturesApp
//
//  Created by Ksusha on 12.05.2022.
//

import Foundation

protocol AuthPresenterProtocol: AnyObject {
    var controller: AuthViewControllerProtocol? { get set }
    
    func viewDidLoad()
    func getToken(with code: String)
}

final class AuthPresenter: AuthPresenterProtocol {
    
    weak var controller: AuthViewControllerProtocol?
    private var code: String = ""
    
    func viewDidLoad() {
        if let request = makeRequest() {
            controller?.loadRequest(request)
        }
    }
    
    private func makeRequest() -> URLRequest? {
        guard let url = URL(string: Constants.url) else { return nil }
        return URLRequest(url: url)
    }
    
    func getToken(with code: String) {
        controller?.showLoader()
        
        let urlToken = "https://unsplash.com/oauth/token?client_id=\(Constants.accessKey ?? "")&client_secret=\(Constants.secretKey ?? "")&redirect_uri=\(Constants.redirectUri ?? "")&code=\(code)&grant_type=authorization_code"
        
        guard let url = URL(string: urlToken) else { return }
        Provider.shared.loadData(url: url) { [weak self] (model: UserData) in
            UserDefaultsStorage.shared.saveData(data: model)
            DispatchQueue.main.async {
                self?.controller?.openNext()
            }
        }
    }
}
