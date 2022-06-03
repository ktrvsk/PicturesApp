//
//  UserDefaults.swift
//  PicturesApp
//
//  Created by Ksusha on 13.05.2022.
//

import Foundation


protocol UserDefaultsStorageProtocol {
    func saveData(data: UserModel)
}

final class UserDefaultsStorage: UserDefaultsStorageProtocol {
    
    static var shared =  UserDefaultsStorage()

      private init() {}
    
    private var standart = UserDefaults.standard
    
    private enum UserKey: String {
        case accessToken
        case tokenType
        case refreshToken
    }

    func saveData(data: UserModel) {
        standart.set(data.accessToken, forKey: UserKey.accessToken.rawValue)
        let data = standart.string(forKey: UserKey.accessToken.rawValue)
        print(data!)
    }
}
