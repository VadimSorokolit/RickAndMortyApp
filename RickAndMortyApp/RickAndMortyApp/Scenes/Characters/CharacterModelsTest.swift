//
//  CharactersModelsTest.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import UIKit

enum CharacterModels {
    
    enum DisplayCharacters {
        struct Request {
            let page: Int
        }
        struct Response {
            let characters: [CharResult]
        }
        struct ViewModel {
            struct characterInformationModel {
                let id: Int
                let name: String
                let image: String
            }
            var characterInformation: [characterInformationModel]
            var errorMessage: String?
        }
    }
    
}


    

