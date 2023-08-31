//
//  PokemonListResponse.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation

struct PokemonListResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonListItem]
}
