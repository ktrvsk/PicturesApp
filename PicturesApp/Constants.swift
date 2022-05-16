//
//  Constants.swift
//  PicturesApp
//
//  Created by Ksusha on 12.05.2022.
//

import Foundation

enum Constants {
    static let accessKey = Bundle.main.infoDictionary?["ACCESS_KEY"] as? String
    static let redirectUri = Bundle.main.infoDictionary?["REDIRECT_URL"] as? String
    static let secretKey = Bundle.main.infoDictionary?["SECRET_KEY"] as? String
    
    static let url = "https://unsplash.com/oauth/authorize?client_id=\(accessKey ?? "")&redirect_uri=\( redirectUri ?? "")&response_type=code&scope=public+read_user"
}
