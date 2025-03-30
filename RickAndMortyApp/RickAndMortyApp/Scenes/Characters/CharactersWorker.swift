//
//  CharactersWorker.swift
//  RickAndMortyApp
//
//  Created by Vadim Sorokolit on 28.03.2025.
//
    

import Foundation
import Alamofire

protocol CharactersWorkerProtocol: AnyObject {
    typealias CompletionHandler = ((Result<Characters, Error>) -> Void)
    
    func fetchCharacters(page: Int, completion: @escaping CompletionHandler)
}

class CharactersWorker: CharactersWorkerProtocol {
    
    // MARK: - Properties
    
    private let baseUrl = "https://rickandmortyapi.com/api/character"
    private let coreDataManager: CoreDataManager
    
    // MARK: - Initializer
    
    init(coreDataManager: CoreDataManager) {
        self.coreDataManager = coreDataManager
    }
    
    // MARK: - Methods
    
    func fetchCharacters(page: Int, completion: @escaping CompletionHandler) {
        let parameters: [String: Any] = ["page": page]

        AF.request(baseUrl, parameters: parameters)
            .validate()
            .responseData { response in
                switch response.result {
                    case .success(let data):
                        do {
                            let characters = try JSONDecoder().decode(Characters.self, from: data)
                            self.coreDataManager.saveCharacters(characters: characters.results)
                            completion(.success(characters))
                        } catch {
                            completion(.failure(error))
                        }
                        
                    case .failure:
                        self.coreDataManager.fetchCharacters { result in
                            switch result {
                                case .success(let entities) where !entities.isEmpty:
                                    let charResults = entities.map { $0.toCharResult() }
                                    let info = Info(count: charResults.count, pages: 1, next: "", prev: nil)
                                    let characters = Characters(info: info, results: charResults)
                                    completion(.success(characters))
                                case .success, .failure:
                                    let noDataError = NSError(
                                        domain: "",
                                        code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "No internet connection and no cached data."]
                                    )
                                    completion(.failure(noDataError))
                            }
                        }
                }
            }
    }
    
}


