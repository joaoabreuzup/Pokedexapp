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
    func getPokemonListCount() -> Int
    func getPokemonImageUrl(indexPathRow: Int) -> URL?
    func getPokemonId(indexPathRow: Int) -> Int
    func getPokemonName(indexPathRow: Int) -> String
    func getPokemonFirstType(indexPathRow: Int) -> TypeClass
    func getPokemonTypes(indexPathRow: Int) -> [Types]
    var delegate: HomeScreenViewModelDelegate? { get set }
}

protocol HomeScreenViewModelDelegate {
    func reloadData()
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    // MARK: - Model
    private var pokemonList: PokemonList? {
        didSet {
            dispatchGroup.notify(queue: .main) {
                self.delegate?.reloadData()
            }
        }
    }
    
    // MARK: - Dependencies
    private var pokemonUrlList: PokemonUrlList?
    private var service: HomeScreenServiceProtocol
    var delegate: HomeScreenViewModelDelegate?
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
    }
    
    // MARK: - Private Methods
    private func fetchPokemon(with url: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
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
    
    private func fillPokemonList() {
        pokemonList = PokemonList(list: [])
        pokemonUrlList?.results?.forEach {
            guard let url = $0.url else {
                return
            }
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
    
    // MARK: - Public Methods
    func fetchPokemonUrlList() {
        dispatchGroup.enter()
        service.fetchPokemonUrlList { result in
            switch result {
            case .success(let list):
                self.pokemonUrlList = list
                self.dispatchGroup.leave()
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.dispatchGroup.enter()
            self.fillPokemonList()
            self.dispatchGroup.leave()
        }
    }
    
    func getPokemonListCount() -> Int {
        return pokemonList?.list.count ?? 0
    }
    
    func getPokemonImageUrl(indexPathRow: Int) -> URL? {
        return URL(string: pokemonList?.list[indexPathRow].sprites?.other?.officialArtwork?.frontDefault ?? "")
    }
    
    func getPokemonId(indexPathRow: Int) -> Int {
        return pokemonList?.list[indexPathRow].id ?? 0
    }
    
    func getPokemonName(indexPathRow: Int) -> String {
        return pokemonList?.list[indexPathRow].name ?? ""
    }
    
    func getPokemonFirstType(indexPathRow: Int) -> TypeClass {
        return pokemonList?.list[indexPathRow].types?.first?.type ?? TypeClass(name: nil)
    }
    
    func getPokemonTypes(indexPathRow: Int) -> [Types] {
        return pokemonList?.list[indexPathRow].types ?? []
    }
    
}
