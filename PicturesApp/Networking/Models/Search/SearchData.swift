//
//  Search.swift
//  PicturesApp
//
//  Created by Ksusha on 17.05.2022.
//

import Foundation

struct SearchData: Decodable {
    let total: Int
    let results: [PictureData]
}

struct PictureData: Decodable {
    let width: Int
    let height: Int
//    let description: String
    let urls: [URLKing.RawValue:String]
    
    enum URLKing: String {
        case raw
        case full
        case regular
        case small
        case thumb
    }
}


