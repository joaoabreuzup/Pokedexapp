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
    func fetchPokemon(with url: String, completion: @escaping (Result<Pokemon, Error>) -> Void)
    func getPokemonListCount() -> Int
    func getPokemonImageUrl(indexPathRow: Int) -> URL?
    func getPokemonId(indexPathRow: Int) -> Int
    func getPokemonName(indexPathRow: Int) -> String
    func getPokemonUrl(indexPathRow: Int) -> String
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    // MARK: - Model
    private var pokemonUrlList: PokemonUrlList?
    private var pokemonList: PokemonList = PokemonList(list: [])
    
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
                if self.pokemonUrlList?.results?.count == 20 {
                    self.fetchPokemons()
                }
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
                print(err.localizedDescription)
                completion(.failure(err))
                
            }
        }
    }
    
    private func fetchPokemons() {
        pokemonUrlList?.results?.forEach {
            guard let url = $0.url else {
                return
            }
            fetchPokemon(with: url) { result in
                switch result {
                case .success(let pokemon):
                    self.pokemonList.list.append(pokemon)
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
        }
    }
    
    func getPokemonListCount() -> Int {
        return pokemonList.list.count
    }
    
    func getPokemonImageUrl(indexPathRow: Int) -> URL? {
        return URL(string: pokemonList.list[indexPathRow].sprites?.other?.officialArtwork?.frontDefault ?? "")
    }
    
    func getPokemonId(indexPathRow: Int) -> Int {
        return pokemonList.list[indexPathRow].id ?? 0
    }
    
    func getPokemonName(indexPathRow: Int) -> String {
        return pokemonList.list[indexPathRow].name ?? ""
    }
    
    func getPokemonUrl(indexPathRow: Int) -> String {
        return pokemonUrlList?.results?[indexPathRow].url ?? ""
    }
    
}
