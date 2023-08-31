//
//  PokemonService.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation
import Combine

protocol PokemonServiceProtocol {
    
    func getAllPokemons(completion: @escaping (Result<PokemonListResponse, Error>) -> Void)
}

struct PokemonService: PokemonServiceProtocol {
    
    
    private var networkManager: NetworkManager = NetworkManager.shared
    
    func getAllPokemons(completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        
        let request = Request(endpoint: .pokemon)
        
        networkManager.execute(request, expecting: PokemonListResponse.self, completion: completion)
        
    }
    
    
}
