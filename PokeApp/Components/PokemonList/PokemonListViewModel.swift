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
    public var pokemonList: [PokemonListItem] = []
    @Published var pokemonListResponse: PokemonListResponse?
    @Published var isLoading : Bool?
    
    init(pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemonService = pokemonService
    }
    
    func fetchPokemons(offSet: Int = 0) {
        
        // only first call
        if pokemonList.isEmpty { self.isLoading = true }
        pokemonService.getAllPokemons(offSet: offSet) {[weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                
                //only first call
                if pokemonList.isEmpty { self.isLoading = false }
                
                pokemonListResponse = response
                if offSet == 0 {
                    pokemonList = response.results
                } else {
                    pokemonList.append(contentsOf: response.results)
                }
                
            case .failure(let failure):
                print(failure)
                //TODO: manage error
                if pokemonList.isEmpty { self.isLoading = false }
                pokemonListResponse = nil
            }
        }
    }
    
}
