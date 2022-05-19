//
//  ImageData.swift
//  PicturesApp
//
//  Created by Ksusha on 18.05.2022.
//

import Foundation

struct ImageData: Codable {
    let id: String
    let urls: UrlImage
}

struct UrlImage: Codable {
    let raw: URL
    let full: URL
    let regular: URL
    let small: URL
    let thumb: URL
}
