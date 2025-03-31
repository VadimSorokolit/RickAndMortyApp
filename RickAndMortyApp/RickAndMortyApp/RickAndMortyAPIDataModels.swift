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
        let species: String
        let type: String
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
    
    init(entity: CharacterEntity) {
        self.id = Int(entity.id)
        self.name = entity.name ?? "Unknown"
        self.image = entity.iconURL ?? ""
        self.status = .unknown
        self.species = entity.species ?? ""
        self.type = entity.type ?? ""
        self.gender = Gender(rawValue: entity.gender ?? "") ?? .unknown
        self.origin = Location(name: "", url: "")
        self.location = Location(name: "", url: "")
        self.episode = []
        self.url = ""
        self.created = ""
    }
    
}



    

