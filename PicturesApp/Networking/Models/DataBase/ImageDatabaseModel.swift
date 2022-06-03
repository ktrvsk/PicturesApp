//
//  Database.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//
import RealmSwift

final class ImageDatabaseModel: Object {
    @objc dynamic var image = ""
    @objc dynamic var id = ""
}
