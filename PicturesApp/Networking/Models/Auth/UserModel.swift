//
//  UserModel.swift
//  PicturesApp
//
//  Created by Ksusha on 12.05.2022.
//

import Foundation

struct UserModel: Decodable {
    let accessToken: String
    let tokenType: String
    let refreshToken: String
    let scope: String
    let createdAt: Int
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case refreshToken = "refresh_token"
        case scope = "scope"
        case createdAt = "created_at"
    }
}
