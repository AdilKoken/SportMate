//
//  Structs.swift
//  SportMateFinder
//
//  Created by Adil Köken on 20.12.20.
//

import Foundation

//CREATE
struct cityList: Codable {
    var Cities_Germany: [CityWithState]
}

struct CityWithState: Codable {
    var name: String
    var state: String
}

//REGISTRATION
struct CountryCode: Codable {
    var name: String
    var code: String
}

struct CountryCodeList: Codable {
    var country_list: [CountryCode]
}

struct CountryWithStatesList: Codable {
    var countries: [CountryWithStates]
}

struct CountryWithStates: Codable {
    var country: String
    var states: [String]
}
<<<<<<< HEAD
=======

struct Assignment {
    var username: String
    var eventID: Int
    var time: Int
}
>>>>>>> 81324ca (Initial Commit)
