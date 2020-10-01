//
//  HomeScreenService.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 29/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

enum CustomError: Error {
    case parseError(String)
    case networkError(String)
}

protocol HomeScreenServiceProtocol {
    func fetchPokemonUrlList(completion: @escaping (Result<PokemonUrlList,Error>) -> Void)
    func fetchPokemon(with url: String?, completion: @escaping (Result<Pokemon,Error>) -> Void)
}

class HomeScreenService: HomeScreenServiceProtocol {
    
    // MARK: - Dependencies
    var networkDispatcher: NetworkDispatcherProtocol
    
    // MARK: - Init
    init(networkDispatcher: NetworkDispatcherProtocol = NetworkDispatcher()) {
        self.networkDispatcher = networkDispatcher
    }
    
    // MARK: - Methods
    func fetchPokemonUrlList(completion: @escaping (Result<PokemonUrlList, Error>) -> Void) {
        networkDispatcher.request(url: Urls.pokemonListUrl) { result in
            switch result {
            case .success(let data):
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonUrlList.self, from: data)
                    completion(.success(pokemonList))
                } catch {
                    completion(.failure(CustomError.parseError("❌ Parse Error!")))
                }
            case .failure(let error):
                completion(.failure(CustomError.networkError(error.localizedDescription)))
            }
        }
    }
    
    func fetchPokemon(with url: String?, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        guard let url = url else {return}
        networkDispatcher.request(url: url) { result in
            switch result {
            case .success(let data):
                do {
                    let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                    completion(.success(pokemon))
                } catch {
                    completion(.failure(CustomError.parseError("❌ Parse Error!")))
                }
            case .failure(let error):
                completion(.failure(CustomError.networkError(error.localizedDescription)))
            }
        }
    }

}
