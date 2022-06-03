//
//  RealmDatabase.swift
//  PicturesApp
//
//  Created by Ksusha on 03.06.2022.
//

import RealmSwift

final class RealmDataBase {
    static var shared: RealmDataBase = {
        RealmDataBase()
    }()
    
    private init() {}
    
    private var realm: Realm? = {
        var realm: Realm?
        do {
            realm = try Realm()
        } catch let error as NSError {
            print(error)
        }
        return realm
    }()
    
    func read<T: Object>() -> Results<T>? {
        realm?.objects(T.self)
    }
    
    func write(closure: ThrowsVoidClosure) {
        do {
            try realm?.write(closure)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func delete(_ object: ObjectBase) {
        realm?.delete(object)
    }
    
    func add(_ object: Object) {
        realm?.add(object)
    }
}
