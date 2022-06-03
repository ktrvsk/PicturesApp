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
    
    public func makeRequest() -> URLRequest? {
        guard let url = URL(string: ConstantsNetworking.url) else {
            return nil
        }
        return URLRequest(url: url)
    }
    
    func getToken(with code: String) {
        controller?.showLoader()
        
        let urlToken = "https://unsplash.com/oauth/token?client_id=\(ConstantsNetworking.accessKey ?? "")&client_secret=\(ConstantsNetworking.secretKey ?? "")&redirect_uri=\(ConstantsNetworking.redirectUri ?? "")&code=\(code)&grant_type=authorization_code"
        
        guard let url = URL(string: urlToken) else {
            return
        }
        Provider.shared.loadData(url: url, method: .POST) { [weak self] (model: UserModel) in
            UserDefaultsStorage.shared.saveData(data: model)
            DispatchQueue.main.async {
                self?.controller?.openNext()
            }
        }
    }
}
