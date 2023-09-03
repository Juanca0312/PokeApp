//
//  PokemonListItem.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation


struct PokemonListItem: Codable {
    let name: String
    let url: String
    var id: String {
        guard let pokemonId = URL(string: url)?.lastPathComponent else {
            fatalError("error pokemon id")
        }
        return pokemonId
    }
}

extension PokemonListItem {
    
    private static let imagesStringUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
    
    var imageUrl: URL? {
        
        let pokemonImageStringUrl = PokemonListItem.imagesStringUrl + self.id + ".png"
        return URL(string: pokemonImageStringUrl)
        
    }
}
