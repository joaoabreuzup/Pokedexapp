//
//  HomeScreenModel.swift
//  Pokedex
//
//  Created by João Jacó Santos Abreu on 29/09/20.
//  Copyright © 2020 João Jacó Santos Abreu. All rights reserved.
//

import Foundation

// MARK: - PokemonList
struct PokemonUrlList: Codable {
    let results: [Results]?
}

// MARK: - Results
struct Results: Codable {
    let url: String?
}

struct PokemonList: Codable {
    var list: [Pokemon]
}

// MARK: - Pokemon
struct Pokemon: Codable {
    let name: String?
    let sprites: Sprites?
    let types: [Types]?
}

// MARK: - Sprites
struct Sprites: Codable {
    let other: Other?
}

// MARK: - Other
struct Other: Codable {
    let officialArtwork: OfficialArtwork?

    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
    }
}

// MARK: - OfficialArtwork
struct OfficialArtwork: Codable {
    let frontDefault: String?

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

// MARK: - Types
struct Types: Codable {
    let slot: Int?
    let type: TypeClass?
}

// MARK: - TypeClass
struct TypeClass: Codable {
    let name: String?
    let url: String?
}
