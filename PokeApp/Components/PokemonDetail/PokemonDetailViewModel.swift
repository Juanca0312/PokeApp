//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import Foundation

struct PokemonDetailViewModel {
    let pokemon: PokemonListItem
    
    init(pokemon: PokemonListItem) {
        self.pokemon = pokemon
    }
    
    public var title: String {
        pokemon.name.uppercased()
    }
}
