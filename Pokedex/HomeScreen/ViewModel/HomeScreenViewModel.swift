//
//  HomeScreenViewModel.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 30/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

protocol HomeScreenViewModelProtocol {
    func fetchPokemonUrlList(url: String)
    func getNextPageUrl() -> String
    var collectionViewModel: CollectionViewModelProtocol? { get set }
}

protocol HomeScreenViewModelDelegate {
    func reloadData()
}

class HomeScreenViewModel: HomeScreenViewModelProtocol {
    
    // MARK: - Model
    private var pokemonList: PokemonList? {
        didSet {
            collectionViewModel?.setPokemonList(pokemonList: self.pokemonList ?? PokemonList(list: []))
        }
    }
    
    private var realPokemonList: PokemonList?
    
    // MARK: - Dependencies
    public var collectionViewModel: CollectionViewModelProtocol?
    private var allPokemonUrls: PokemonUrlList?
    private var pokemonUrlList: PokemonUrlList?
    private var service: HomeScreenServiceProtocol
    var delegate: HomeScreenViewModelDelegate?
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Init
    init(service: HomeScreenServiceProtocol = HomeScreenService()) {
        self.service = service
        fetchAllPokemonUrls()
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
    
    private func fillPokemonList(pokemonUrlList: [Results]?) {
        guard let resultList = pokemonUrlList?.count else {return}
        pokemonList = pokemonList == nil ? PokemonList(list: []) : pokemonList
        for i in 0..<resultList {
            dispatchGroup.enter()
            guard let url = pokemonUrlList?[i].url else { return }
            fetchPokemon(with: url) { result in
                switch result {
                case .success(let pokemon):
                    var pokemonNameCapitalized = pokemon
                    if pokemonNameCapitalized.sprites?.other?.officialArtwork?.frontDefault != nil {
                        pokemonNameCapitalized.name?.capitalizeFirstLetter()
                        self.pokemonList?.list.append(pokemonNameCapitalized)
                        self.dispatchGroup.leave()
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                    self.dispatchGroup.leave()
                }
                
            }
            dispatchGroup.notify(queue: .main) {
                self.sortPokemonList()
            }
        }
    }
    
    private func sortPokemonList() {
        pokemonList?.list.sort {
            guard let id1 = $0.id, let id2 = $1.id else {return false}
            return id1 < id2
        }
    }
    
    private func fetchAllPokemonUrls() {
        service.fetchPokemonUrlList(url: Urls.allPokemonUrls) { result in
            switch result {
            case .success(let list):
                self.allPokemonUrls = list
            case .failure(let err):
                print(err.localizedDescription)
            }
        }
    }
    
    // MARK: - Public Methods
    func searchPokemon(name: String) {
        let resultListPokemon = allPokemonUrls?.results?.filter({
            ($0.name?.contains(name) ?? false)
        })
        if name != "" {
            realPokemonList = pokemonList
            pokemonList?.list.removeAll()
            fillPokemonList(pokemonUrlList: resultListPokemon)
            
        } else {
            pokemonList = realPokemonList
        }
        print("resultados para \(name): \(String(describing: resultListPokemon))")
    }
    
    func fetchPokemonUrlList(url: String) {
        dispatchGroup.enter()
        service.fetchPokemonUrlList(url: url) { result in
            switch result {
            case .success(let list):
                self.pokemonUrlList = list
                self.dispatchGroup.leave()
            case .failure(let err):
                print(err.localizedDescription)
                self.dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            self.dispatchGroup.enter()
            self.fillPokemonList(pokemonUrlList: self.pokemonUrlList?.results)
            self.dispatchGroup.leave()
        }
    }
    
    func getNextPageUrl() -> String {
        return pokemonUrlList?.next ?? ""
    }
    
}
