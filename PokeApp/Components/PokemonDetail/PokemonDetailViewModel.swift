//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import Foundation

struct PokemonDetailViewModel {
    let pokemon: PokemonListItem
    private let pokemonService: PokemonServiceProtocol
    
    enum SectionType: CaseIterable {
        case images
        case info
        case stats
        case damageRelations
    }
    
    public let sections = SectionType.allCases
    
    init(pokemon: PokemonListItem, pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemon = pokemon
        self.pokemonService = pokemonService
    }
    
    public var title: String {
        pokemon.name.uppercased()
    }
    
    public func fetchPokemon() {
        guard let intId = Int(pokemon.id) else {
            fatalError("id not found")
        }
        pokemonService.getPokemonById(id: intId) { resul in
            switch resul {
            case .success(let result):
                print(String(describing: result))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
