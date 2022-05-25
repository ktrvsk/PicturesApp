//
//  Database.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation
import GRDB

struct Database {
    var image: String
    var id: String
}

extension Database: Codable, FetchableRecord, MutablePersistableRecord { }
