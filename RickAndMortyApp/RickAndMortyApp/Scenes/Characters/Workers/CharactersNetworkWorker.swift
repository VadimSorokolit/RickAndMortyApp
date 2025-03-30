//
//  CharactersNetworkWorker.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import Foundation
import Alamofire

protocol CharactersNetworkWorkerProtocol: AnyObject {
    typealias CompletionHandler = ((Result<Characters, Error>) -> Void)
    
    func fetchCharacters(page: Int, completion: @escaping CompletionHandler)
}

class CharactersNetworkWorker: CharactersNetworkWorkerProtocol {
    
    // MARK: - Properties
    
    private let baseUrl = "https://rickandmortyapi.com/api/character"
    
    func fetchCharacters(page: Int, completion: @escaping CompletionHandler) {
        let parameters: [String: Any] = ["page": page]
        
        AF.request(baseUrl, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let characters = try JSONDecoder().decode(Characters.self, from: data)
                            completion(.success(characters))
                        } catch {
                            completion(.failure(error))
                        }
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
    }

}


