//
//  PokemonListViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation
import Combine

class PokemonListViewModel {
    private let pokemonService: PokemonServiceProtocol
    @Published var pokemonList: [PokemonListItem]?
    @Published var isLoading : Bool?
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemons() {
        isLoading = true
        pokemonService.getAllPokemons {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                self.isLoading = false
                pokemonList = response.results
            case .failure(let failure):
                print(failure)
                //TODO: manage error
                isLoading = false
                pokemonList = nil
            }
        }
    }
    
}
