//
//  UserDatabase.swift
//  SportMateFinder
//
//  Created by Adil Köken on 18.10.20.
//

import Foundation
import SQLite3

<<<<<<< HEAD
=======

>>>>>>> 81324ca (Initial Commit)
struct User {
    var id: Int32
    var mail: String
    var username: String
<<<<<<< HEAD
    var passwort: String
    var age: Int16
=======
    var password: String
    var age: Int
    var country: String
    var state: String
}


struct Logged {
    static var user = User(id: -1,mail: "",username: "",password: "",age: 1,country:"",state:"")
>>>>>>> 81324ca (Initial Commit)
}

class UserDatabase {
    var database: OpaquePointer?
    
    static let shared = UserDatabase()
    
    private init () {
    }
    
    func connect() {
        if database != nil {
            return
        }
        
        let databaseURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("users.sqlite")
        
        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
            print("Error opening database")
        }
        
<<<<<<< HEAD
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS users (mail TEXT, username TEXT, passwort TEXT, age INT)", nil, nil, nil) != SQLITE_OK {
=======
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS users (mail TEXT, password TEXT, username TEXT, age INT, country TEXT, state TEXT)", nil, nil, nil) != SQLITE_OK {
>>>>>>> 81324ca (Initial Commit)
            print("ERROR creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
<<<<<<< HEAD
    func register(user: User) -> Int {
        connect()
        
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(
            database,
            "INSERT INTO users (mail, username, passwort, age) VALUES (?, ?, ?, ?)",
=======
    func register(user: User) {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(
            database,
            "INSERT INTO users (mail, username, password, age, country, state) VALUES (?, ?, ?, ?, ?, ?)",
>>>>>>> 81324ca (Initial Commit)
            -1, &statement, nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: user.mail).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string: user.username).utf8String, -1, nil)
<<<<<<< HEAD
            sqlite3_bind_text(statement, 3, NSString(string: user.passwort).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, Int32(user.age))
=======
            sqlite3_bind_text(statement, 3, NSString(string: user.password).utf8String, -1, nil)
            sqlite3_bind_int(statement, 4, Int32(user.age))
            sqlite3_bind_text(statement, 5, NSString(string: user.country).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, NSString(string: user.state).utf8String, -1, nil)
>>>>>>> 81324ca (Initial Commit)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("ERROR inserting registration into table")
            }
        }
        else {
            print("Error creating note insert statement")
        }
<<<<<<< HEAD
        
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
        //so the user logs in immediatly after registration, use this rowid
    }
    
    func login(username: String, passwort: String) -> User {
        connect()
        
        var user = User(id: -1, mail: "", username: "", passwort: "", age: 1)
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(statement,
                              "SELECT rowid, mail, username, passwort, age",
                              -1, &statement, nil
        ) == SQLITE_OK {
            user.id = sqlite3_column_int(statement, 0)
            user.mail = String(cString: sqlite3_column_text(statement, 1))
            user.username = String(cString: sqlite3_column_text(statement, 2))
            user.passwort = String(cString: sqlite3_column_text(statement, 3))
            user.age = Int16(sqlite3_column_int(statement, 4))
=======
        Logged.user.id = Int32(Int(sqlite3_last_insert_rowid(database)))
        sqlite3_finalize(statement)
        
        print(String(Logged.user.id), "username: ", user.username, "password: ", user.password)
}
    
    func login(username: String, password: String) {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "SELECT rowid, mail, username, country, state FROM users WHERE username = ? AND password = ?",
                              -1, &statement, nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: username).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string: password).utf8String, -1, nil)
            
            //if I get a row, than save the user as logged in
            if sqlite3_step(statement) == SQLITE_ROW {
                Logged.user.id = sqlite3_column_int(statement, 0)
                Logged.user.mail = String(cString: sqlite3_column_text(statement, 1))
                Logged.user.username = String(cString: sqlite3_column_text(statement, 2))
                Logged.user.country = String(cString: sqlite3_column_text(statement, 3))
                Logged.user.state = String(cString: sqlite3_column_text(statement, 4))
            }
            else {
                // user.id = 0 means none user
                Logged.user.id = 0
                Logged.user.mail = "_"
                Logged.user.username = "_"
            }
>>>>>>> 81324ca (Initial Commit)
        }
        else {
            print("ERROR matching the user in database")
        }
<<<<<<< HEAD
        return user
        
    }
=======
    }
    
    // a function to check if the username already exists or not, usage by registration
    func userNameCheck(username: String) -> Bool {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database,
                              "SELECT rowid, username FROM users WHERE username = ?",
                              -1, &statement, nil)
            == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: username).utf8String, -1, nil)
            
            //if select gets a row, means true
            if sqlite3_step(statement) == SQLITE_ROW {
                return true
            }
            else {
                return false
            }
        }
        else {
            print("ERROR: could not acces the database in order to checkif the username exists")
            return true
        }
        
        
    }
    
    func UserIdFind() {
        connect()
        var statement: OpaquePointer? = nil
        let id = UserDefaults.standard.integer(forKey: "UserID")
        
        if sqlite3_prepare_v2(database,
                              "SELECT rowid, mail, username, country, state, age FROM users WHERE rowid = ?",
                              -1, &statement, nil)
            == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            //if select gets a row, means true
            if sqlite3_step(statement) == SQLITE_ROW {
                Logged.user.id = sqlite3_column_int(statement, 0)
                Logged.user.mail = String(cString: sqlite3_column_text(statement, 1))
                Logged.user.username = String(cString: sqlite3_column_text(statement, 2))
                Logged.user.country = String(cString: sqlite3_column_text(statement, 3))
                Logged.user.state = String(cString: sqlite3_column_text(statement, 4))
                let birthDate = Date(timeIntervalSince1970: TimeInterval(Int(sqlite3_column_int(statement, 5))))
                let today = Date(timeIntervalSince1970: Date().timeIntervalSince1970)
                let calendar = Calendar.current
                let components = calendar.dateComponents([.year], from: birthDate, to: today)
                Logged.user.age = components.year ?? 14
            }
        }
        else {
             print("Error locating the default user")
        }
    }
    
    //the functing gets all the saved users in system and returns them in a list
    func gatherall() -> [User] {
        connect()
        
        var result: [User] = []
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "SELECT rowid, mail, username, password, age, country, state FROM users", -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(User(
                    id: sqlite3_column_int(statement, 0),
                    mail: String(cString: sqlite3_column_text(statement, 1)),
                    username: String(cString: sqlite3_column_text(statement, 2)),
                    password: String(cString: sqlite3_column_text(statement, 3)),
                    age: Int(Int16(sqlite3_column_int(statement, 4))),
                    country: String(cString: sqlite3_column_text(statement, 5)),
                    state: String(cString: sqlite3_column_text(statement, 6))
                ))
            }
        }
        /*
         for item in result {
            print(item.id, item.username, item.password)
         }
         */
        return result
    }
    
    //erasing the database to start over
    func ereseDatabase() {
        
        if sqlite3_exec(database, "DROP TABLE users", nil, nil, nil) != SQLITE_OK {
            print("Database is erased: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }

>>>>>>> 81324ca (Initial Commit)
}
