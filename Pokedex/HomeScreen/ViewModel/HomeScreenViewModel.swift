//
//  HomeScreenViewModel.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

protocol HomeScreenViewModelProtocol {
    func fetchPokemonUrlList()
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    // MARK: - Model
    private var pokemonUrlList: PokemonUrlList?
    private var pokemonList: PokemonList?
    
    // MARK: - Dependencies
    private var service: HomeScreenServiceProtocol
    
    // MARK: - Init
    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
    }
    
    // MARK: - Methods
    func fetchPokemonUrlList() {
        service.fetchPokemonUrlList { result in
            switch result {
            case .success(let list):
                self.pokemonUrlList = list
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    func fetchPokemon(with url: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        service.fetchPokemon(with: url) { result in
            switch result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let err):
                completion(.failure(err))
            }
        }
    }
    
    func fillPokemonList() {
        pokemonUrlList?.results?.forEach {
            guard let url = $0.url else { return }
            fetchPokemon(with: url) { result in
                switch result {
                case .success(let pokemon):
                    self.pokemonList?.list.append(pokemon)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }

        }
    }
    
}
