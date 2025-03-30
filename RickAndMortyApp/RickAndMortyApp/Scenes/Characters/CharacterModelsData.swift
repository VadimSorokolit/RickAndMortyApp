//
//  CharactersModelsData.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import Foundation

enum CharacterModels {
    
    enum DisplayCharacters {
        
        struct Request {
            let page: Int
        }
        
        struct Response {
            let characters: [CharResult]
        }
        
        struct ViewModel {
            
            struct CharacterModel {
                let id: Int
                let name: String
                let image: String
            }
            
            init (characterModels: [CharacterModel]) {
                self.characterModels = characterModels
            }
            
            init(errorMessage: String?) {
                self.characterModels = []
                self.errorMessage = errorMessage
            }
            
            var characterModels: [CharacterModel]
            var errorMessage: String?
        }
        
    }
    
}


    

