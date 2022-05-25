//
//  DatabaseManager.swift
//  PicturesApp
//
//  Created by Ksusha on 20.05.2022.
//

import Foundation
import GRDB

var dbQueue: DatabaseQueue!

class DatabaseManager {
    
    private var imageCell = ImageCell()
    
    static var migrator: DatabaseMigrator {
        var migrator = DatabaseMigrator()
        
        migrator.registerMigration("createProject") { db in
            try db.create(table: "project"){ table in
                table.autoIncrementedPrimaryKey("id")
                table.column("name", .text).notNull()
                table.column("description", .text)
                table.column("due", .date)
            }
        }
        return migrator
    }
    
    //подключение к базе данных
//    var dbQueue = try DatabaseQueue(path: "/path/to/database.sqlite")
    
    // создание и подключение к базе данных
    static func setupDatabase(for application: UIApplication) throws {
        let databaseUrl = try FileManager.default
            .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("dg.sqlite")
        dbQueue = try DatabaseQueue(path: databaseUrl.path)
        
        //запуск миграции
        try migrator.migrate(dbQueue)
        
        try dbQueue.write { db in
            var database = Database(
                image: "https://ibb.co/bNstbr0",
                id: "bNstbr0")
            try? database.insert(db)
            print("DATABASE \(database)")
        }
    }
}

