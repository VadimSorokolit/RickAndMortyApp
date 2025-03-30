//
//  RickAndMortyAPIDataModels.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 29.03.2025.
//
    

import Foundation

typealias Info = Characters.Info
typealias CharResult = Characters.CharResult

struct Characters: Decodable {
    let info: Info
    let results: [CharResult]
    
    struct Info: Decodable {
        let count: Int
        let pages: Int
        let next: String
        let prev: String?
    }
    
    struct CharResult: Decodable {
        let id: Int
        let name: String
        let status: Status
        let species, type: String
        let gender: Gender
        let origin, location: Location
        let image: String
        let episode: [String]
        let url: String
        let created: String
        
        enum Gender: String, Decodable {
            case female = "Female"
            case male = "Male"
            case gendless = "Genderless"
            case unknown = "unknown"
        }
        
        struct Location: Decodable {
            let name: String
            let url: String
        }
        
        enum Status: String, Decodable {
            case alive = "Alive"
            case dead = "Dead"
            case unknown = "unknown"
        }
    }
}

extension CharResult {
    init(id: Int, name: String, image: String) {
        self.id = id
        self.name = name
        self.image = image
        self.status = .unknown
        self.species = ""
        self.type = ""
        self.gender = .unknown
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
        self.episode = []
        self.url = ""
        self.created = ""
    }
}

extension Info: Equatable {
    static func == (lhs: Info, rhs: Info) -> Bool {
        return lhs.count == rhs.count &&
        lhs.pages == rhs.pages &&
        lhs.next == rhs.next &&
        lhs.prev == rhs.prev
    }
}

extension CharResult: Equatable {
    static func == (lhs: CharResult, rhs: CharResult) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.image == rhs.image
    }
}

extension Characters: Equatable {
    static func == (lhs: Characters, rhs: Characters) -> Bool {
        return lhs.info == rhs.info &&
            lhs.results == rhs.results
    }
}

    

