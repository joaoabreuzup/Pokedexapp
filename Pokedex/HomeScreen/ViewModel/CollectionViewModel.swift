//
//  CollectionViewModel.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 27/10/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

protocol CollectionViewModelProtocol {
    func getPokemonListCount() -> Int
    func getPokemonImageUrl(indexPathRow: Int) -> URL?
    func getPokemonId(indexPathRow: Int) -> Int
    func getPokemonName(indexPathRow: Int) -> String
    func getPokemonTypes(indexPathRow: Int) -> [Types]
    func setPokemonList(pokemonList: PokemonList)
    var delegate: CollectionViewModelDelegate? { get set }
}

protocol CollectionViewModelDelegate {
    func reloadData()
}

class CollectionViewModel: CollectionViewModelProtocol {
    
    // MARK: - Model
    private var pokemonList: PokemonList? {
        didSet {
            self.delegate?.reloadData()
        }
    }
    
    var delegate: CollectionViewModelDelegate?
    
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
    
    func getPokemonTypes(indexPathRow: Int) -> [Types] {
        return pokemonList?.list[indexPathRow].types ?? []
    }
    
    func setPokemonList(pokemonList: PokemonList) {
        self.pokemonList = pokemonList
    }
    
}
