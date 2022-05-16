//
//  UserDefaults.swift
//  PicturesApp
//
//  Created by Ksusha on 13.05.2022.
//

import Foundation


protocol UserDefaultsProtocol {
    func saveData(data: UserData)
}

final class UserDefaultsStorage: UserDefaultsProtocol {
    
    static var shared: UserDefaultsStorage = {
          let instance = UserDefaultsStorage()
          return instance
      }()

      private init() {}
    
    private var standart = UserDefaults.standard
    
    private enum UserKey: String {
        case accessToken
        case tokenType
        case refreshToken
    }

    func saveData(data: UserData) {
        standart.set(data.accessToken, forKey: UserKey.accessToken.rawValue)
        let data = standart.string(forKey: UserKey.accessToken.rawValue)
        print(data!)
//        standart.set(data.tokenType, forKey: UserKey.tokenType.rawValue)
//        standart.set(data.refreshToken, forKey: UserKey.refreshToken.rawValue)
    }
}
