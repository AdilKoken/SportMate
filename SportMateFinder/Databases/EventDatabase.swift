//
//  Sport.swift
//  SportMateFinder
//
//  Created by Adil Köken on 18.10.20.
//

import Foundation
import SQLite3

struct sportEvent {
<<<<<<< HEAD
    var headLine: String
    var type: String
    var maxPlayer: Int16
    var locationAdress: String
    //the coordinates
    var ageMin: Int16
    var ageMax: Int16
    var date: Date // (?) Calendar
    /*
     .date = Date(timeIntervalSinceReferenceDate: 118800)
     
     let formatter = DateFormatter()
     formatter.locale = Locale(identifier: "en_US")
     formatter.setLocalizedDateFormatFromTemplate("MMMMd")
     ... = formatter.string(from: date) // January 2
     */
    var timeFrom: Date //TO DO
    var timeTill: Date //TO DO
}

class EventManager {
    // TO DO
=======
    var eventID: Int //rowid in sqlite events table !
    var headLine: String
    var type: String
    var maxPlayerCount: Int
    var currentPlayerCount: Int
    var city: String
    var locationAdress: String
    var ageMin: Int
    var ageMax: Int
    var time: Int
    var registredUser: [String] //a list of the usernames from already assigned users
}

struct filter {
    static var filtered: Bool = false
    static var type: String = ""
    static var city: String = ""
    static var dateFrom: Int  = 0
    static var dateTill: Int  = 0
}

class EventDatabase {
    var database: OpaquePointer?
    static let shared = EventDatabase()
    
    private init() {
    }
    
    func connect() {
        if database != nil {
            return
        }
    
        let country = Logged.user.country
        
        let databaseURL = try! FileManager.default.url(
            for: .documentDirectory,
            in: .userDomainMask,
            appropriateFor: nil,
            create: false
        ).appendingPathComponent("events.sqlite")
        
        if sqlite3_open(databaseURL.path, &database) != SQLITE_OK {
            print("Error opening database")
        }
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS IdGenerator (head TEXT, count INT)",
                        nil, nil, nil
        ) != SQLITE_OK {
            print("ERROR creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
        
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS events_\(country) (Key INTEGER PRIMARY KEY AUTOINCREMENT,headline TEXT, type TEXT, maxPlayerCount INT, currentPlayerCount INT, City TEXT, locationAdress TEXT, ageMin INT, ageMax INT, time INT, state TEXT)",
                        nil, nil, nil
        ) != SQLITE_OK {
            print("ERROR creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
        
        if sqlite3_exec(database, "CREATE TABLE IF NOT EXISTS attemptions_\(country) (username TEXT, eventID INT, time INT)", nil, nil, nil) != SQLITE_OK {
            print("ERROR creating table: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    
    //Takes an eventID and returns its current player count
    func selectCurrentPlayerCount(ID: Int) -> Int {
        connect()
        
        let country = Logged.user.country
        var statement: OpaquePointer? = nil
        var count: Int = 0
        
        if sqlite3_prepare_v2(database, "SELECT currentPlayerCount FROM events_\(country) WHERE Key = ?", -1, &statement, nil)
            == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(ID))
            
            if sqlite3_step(statement) != SQLITE_ROW {
                print("ERROR Binding the eventID for selectCurrentPlayerCount: \(String(cString: sqlite3_errmsg(database)!))")
                return 0
            }
            count = Int(sqlite3_column_int(statement, 0))
        }
        else {
            print("ERROR statement selectCurrentPlayerCount: \(String(cString: sqlite3_errmsg(database)!))")
            return 0
        }
        sqlite3_finalize(statement)
        return count
    }
    
    //increases current player count by one,  by assigning or dismissing the assignment. decrease for negative factor
    func increaseCurrentPlayerCount(ID: Int, factor: Int) {
        connect()
        var statement: OpaquePointer? = nil
        let country = Logged.user.country
        
        if sqlite3_prepare_v2(database, "UPDATE events_\(country) SET currentPlayerCount = ? WHERE Key = ?", -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(selectCurrentPlayerCount(ID: ID) + factor) )
            sqlite3_bind_int(statement, 2, Int32(ID))
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("ERROR Step increaseCurrentPlayerCount: \(String(cString: sqlite3_errmsg(database)!))")
            }
        }
        else {
            print("ERROR Statement increasCurrentPlayerCount: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    //To start over, deletes the entire table
    func dropTable(tableName: String) {
        connect()
        let exexutionText = "DROP TABLE \(tableName)"
        
        if sqlite3_exec(database, exexutionText, nil, nil, nil) != SQLITE_OK {
            print("ERROR dropping the table: \(String(cString: sqlite3_errmsg(database)!))")
        }
        else {
            print("OK")
        }
    }
    
    //assigns user to a givent event with eventID
    func assignUser(eventID: Int, time: Int) {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "INSERT INTO attemptions_\(Logged.user.country) (username, eventID, time) VALUES (?,?,?)", -1, &statement, nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: Logged.user.username).utf8String, -1, nil)
            sqlite3_bind_int(statement, 2, Int32(eventID))
            sqlite3_bind_int(statement, 3, Int32(time))
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("ERROR inserting usernames to attemptions: \(String(cString: sqlite3_errmsg(database)!))")
            }
        }
        else {
            print("Error creating note insert statement: \(String(cString: sqlite3_errmsg(database)!))")
        }
        sqlite3_finalize(statement)
        increaseCurrentPlayerCount(ID: eventID, factor: 1)
    }
    // dismiss the assignment from the event
    func dismissAsissignment(eventID: Int) {
        connect()
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "DELETE FROM attemptions_\(Logged.user.country) WHERE eventID = ? AND username = ?", -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(eventID))
            sqlite3_bind_text(statement, 2, NSString(string: Logged.user.username).utf8String, -1, nil)
            if sqlite3_step(statement) == SQLITE_DONE {
                increaseCurrentPlayerCount(ID: eventID, factor: -1)
            }
            else {
                print("Error dismissAssignment Binding: \(String(cString: sqlite3_errmsg(database)!))")
            }
        }
        else {
            print("Error dismissAssignment Statement: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    // creating a new event from a user
    func createEvent (headLine: String, type: String, maxPlayerCount: Int, currentPlayerCount: Int, city: String, locationAdress: String, ageMin: Int, ageMax: Int, time: Int) -> Int {
        let country = Logged.user.country
        connect()
        var statement: OpaquePointer? = nil
        
        let state = Logged.user.state.replacingOccurrences(of: "-", with: "")
    
        if sqlite3_prepare_v2(database, "INSERT INTO events_\(country) (headline, type, maxPlayerCount, currentPlayerCount, City, locationAdress, ageMin, ageMax, time, state) VALUES (?,?,?,?,?,?,?,?,?,?)", -1, &statement, nil
        ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: headLine).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, NSString(string: type).utf8String, -1, nil)
            sqlite3_bind_int(statement, 3, Int32(maxPlayerCount))
            sqlite3_bind_int(statement, 4, Int32(currentPlayerCount))
            sqlite3_bind_text(statement, 5, NSString(string: city).utf8String, -1, nil)
            sqlite3_bind_text(statement, 6, NSString(string: locationAdress).utf8String, -1, nil)
            sqlite3_bind_int(statement, 7, Int32(ageMin))
            sqlite3_bind_int(statement, 8, Int32(ageMax))
            sqlite3_bind_int(statement, 9, Int32(time))
            sqlite3_bind_text(statement, 10, NSString(string: state).utf8String, -1, nil)
            
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error: inserting the new event")
            }
        }
        else {
            print("Error creating event by statement: \(String(cString: sqlite3_errmsg(database)!))")
        }
        sqlite3_finalize(statement)
        return Int(sqlite3_last_insert_rowid(database))
        
    }
    
    //GETHER the assigned user list to an event with the given id and return those in a list
    func getRegistredUsers(id: Int) -> [String] {
        connect()
        var result: [String] = []
        var statement: OpaquePointer? = nil
        let country = Logged.user.country
        
        //finding the rows with eventID
        if sqlite3_prepare_v2(database,
                              "SELECT username FROM attemptions_\(country) WHERE eventID = ?",
                              -1, &statement, nil)
            == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(id))
            
            //appending the list with rows
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(String(cString: sqlite3_column_text(statement, 0)))
            }
        }
        return result
    }
    
    //GETHER ALL ASSIGNMENTS and RETURH THEM IN A LIST -> Check Up
    func geltAllAssignments() -> [Assignment] {
        connect()
        
        var result: [Assignment] = []
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "SELECT username, EventID, time FROM attemptions_\(Logged.user.country)", -1, &statement, nil) == SQLITE_OK {
            
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(
                    Assignment(
                        username: String(cString: sqlite3_column_text(statement, 0)),
                        eventID: Int(sqlite3_column_int(statement, 1)),
                        time: Int(sqlite3_column_int(statement, 2))
                    ))
            }
        }
        else {
            print(String(cString: sqlite3_errmsg(database)!))
        }
        
        return result
    }
    
    //get the assignments of a certain user and return its Eventlist in in a list
    func getMyAssignments() -> [Int] {
        var result: [Int] = []
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "SELECT EventID FROM attemptions_\(Logged.user.country) WHERE username = ?", -1, &statement, nil
            ) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, NSString(string: Logged.user.username).utf8String, -1, nil)
            
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(Int(sqlite3_column_int(statement, 0)))
            }
        }
        else {
            print("ERROR getMyAssignments: String(cString: sqlite3_errmsg(database)!)")
        }
        
        return result
    }
    
    //GETHER ALL EVENTS and RETURN THEM IN A LIST -> Check UP
    func getAllEvents() -> [sportEvent] {
        connect()
        
        var result: [sportEvent] = []
        var statement: OpaquePointer? = nil
        
        let state = Logged.user.state.replacingOccurrences(of: "-", with: "")
        
        if sqlite3_prepare_v2(database, "SELECT Key, headline, type, maxPlayerCount, currentPlayerCount, City, locationAdress, ageMin, ageMax, time FROM events_\(Logged.user.country) WHERE state = ?", -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(statement, 1, NSString(string: state).utf8String, -1, nil)
            while sqlite3_step(statement) == SQLITE_ROW {
                result.append(
                    sportEvent(
                        eventID: Int(sqlite3_column_int(statement, 0)),
                        headLine: String(cString: sqlite3_column_text(statement, 1)),
                        type: String(cString: sqlite3_column_text(statement, 2)),
                        maxPlayerCount: Int(sqlite3_column_int(statement, 3)),
                        currentPlayerCount: Int(sqlite3_column_int(statement, 4)),
                        city: String(cString: sqlite3_column_text(statement, 5)),
                        locationAdress: String(cString: sqlite3_column_text(statement, 6)),
                        ageMin: Int(sqlite3_column_int(statement, 7)),
                        ageMax: Int(sqlite3_column_int(statement, 8)),
                        time: Int(sqlite3_column_int(statement, 9)),
                        registredUser: getRegistredUsers(id: Int(sqlite3_column_int(statement, 0)))
                    ))
            }
        }
        else {
            print(String(cString: sqlite3_errmsg(database)!))
        }
        
        return result
    }
    
    func getOneEvent(id: Int) -> sportEvent {
        connect()
        var result: sportEvent!
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(database, "SELECT Key, headline, type, maxPlayerCount, currentPlayerCount, City, locationAdress, ageMin, ageMax, time FROM events_\(Logged.user.country) WHERE Key = ?", -1, &statement, nil) == SQLITE_OK {
            
            sqlite3_bind_int(statement, 1, Int32(id))
            if sqlite3_step(statement) == SQLITE_ROW {
                result = (
                    sportEvent(
                        eventID: Int(sqlite3_column_int(statement, 0)),
                        headLine: String(cString: sqlite3_column_text(statement, 1)),
                        type: String(cString: sqlite3_column_text(statement, 2)),
                        maxPlayerCount: Int(sqlite3_column_int(statement, 3)),
                        currentPlayerCount: Int(sqlite3_column_int(statement, 4)),
                        city: String(cString: sqlite3_column_text(statement, 5)),
                        locationAdress: String(cString: sqlite3_column_text(statement, 6)),
                        ageMin: Int(sqlite3_column_int(statement, 7)),
                        ageMax: Int(sqlite3_column_int(statement, 8)),
                        time: Int(sqlite3_column_int(statement, 9)),
                        registredUser: getRegistredUsers(id: Int(sqlite3_column_int(statement, 0)))
                    ))
            }
            else {
                print("NOPE")
            }
        }
        else {
            result = sportEvent(eventID: 1, headLine: "", type: "", maxPlayerCount: 0, currentPlayerCount: 1, city: "", locationAdress: "", ageMin: 17, ageMax: 17, time: 0, registredUser: [])
            print(String(cString: sqlite3_errmsg(database)!))
        }
        
        return result
        
    }
    
    func getMyEvents() -> [sportEvent] {
        connect()
        var eventList: [sportEvent] = []
        let listIDs = getMyAssignments()
        
        for ID in listIDs {
            eventList.append(getOneEvent(id: ID))
        }
        return eventList
    }
    
    func deleteOneEvent(forID: Int) {
        connect()
        var statement: OpaquePointer? = nil
        if sqlite3_prepare_v2(database, "DELETE FROM events_\(Logged.user.country) WHERE Key = ?", -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(forID))
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleteEvent: \(String(cString: sqlite3_errmsg(database)!))")
            }
        }
        else {
            print("Error deleteEvent: \(String(cString: sqlite3_errmsg(database)!))")
        }
    }
    
    func cleanOutdated() {
        connect()
        let timeInterval = Date().timeIntervalSince1970
        let timeInt = Int(timeInterval)
        var statement: OpaquePointer? = nil
        
        //Clear Events
        let sqlite3TextEv = "DELETE FROM events_\(Logged.user.country) WHERE time < \(String(timeInt))"
        if sqlite3_exec(database, sqlite3TextEv, nil, nil, nil) != SQLITE_OK {
            print("Error deleteEvent: \(String(cString: sqlite3_errmsg(database)!))")
        }
        
        //Clear Attemptions
        if sqlite3_prepare_v2(database, "DELETE FROM attemptions_\(Logged.user.country) WHERE time < ?", -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_int(statement, 1, Int32(timeInt))
            if sqlite3_step(statement) != SQLITE_DONE {
                print("Error deleteEvent Binding: \(String(cString: sqlite3_errmsg(database)!))")
            }
        }
        else {
            print("Error deleteEvent statement:\(String(cString: sqlite3_errmsg(database)!))")
        }
    }
>>>>>>> 81324ca (Initial Commit)
}
