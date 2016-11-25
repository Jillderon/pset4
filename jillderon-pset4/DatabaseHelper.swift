//
//  DatabaseHelper.swift
//  jillderon-pset4
//
//  Created by Jill de Ron on 21-11-16.
//  Copyright © 2016 Jill de Ron. All rights reserved.
//

import Foundation
import SQLite

class DatabaseHelper {
    private let todos = Table("todos")
    private let id = Expression<Int64>("id")
    private let todo = Expression<String?>("todo")
    
    
    // make a SQL database
    private var database: Connection?
    
    private func setupDatabase() throws {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            database = try Connection("\(path)/db2.sqlite3")
            try createTable()
        } catch {
            throw error
        }
        
    }
    
    // set up database when app is started
    init?(){
        do {
            try setupDatabase()
        } catch {
            return nil
        }
    }
    
    // create a table within the database
    private func createTable() throws {
        do {
                try database!.run(todos.create(ifNotExists: true){
                    t in
                    t.column(id, primaryKey: .autoincrement)
                    t.column(todo)
                })
        } catch {
            throw error
        }
    }
    
    // add todo's to the database
    func create(todo: String) throws {
        
        let insert = todos.insert(self.todo <- todo)
        
        do {
            let rowId = try database!.run(insert)
            print(rowId)
        } catch {
            throw error
        }
    }
    
    // read the database 
    func read() throws -> [String?] {
    
        var result = [String?]()
    
        do {
            for item in try database!.prepare(todos.select(todo)) {
                result.append(item[todo])
            }
        } catch {
          throw error
        }
        
        return result
    }
    
    // remove todo from database. Cited from https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#deleting-rows
    func remove(withName name: String) throws {
        let item = todos.filter(todo == name)
        let _ = try database!.run(item.delete())
    }
}
