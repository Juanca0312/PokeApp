//
//  PokemonService.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 30/08/23.
//

import Foundation
import Combine

protocol PokemonServiceProtocol {
    
    func getAllPokemons(offSet: Int, completion: @escaping (Result<PokemonListResponse, Error>) -> Void)
}

struct PokemonService: PokemonServiceProtocol {
    
    public static let pageLimit = 30
    
    
    private var networkManager: NetworkManager = NetworkManager.shared
    
    func getAllPokemons(offSet: Int, completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        
        var queryItems = [
            URLQueryItem(name: "limit", value: String(PokemonService.pageLimit))
        ]
        var request = Request(endpoint: .pokemon, queryItems: queryItems)
        if offSet != 0 {
            queryItems.append(URLQueryItem(name: "offset", value: String(offSet)))
            request = Request(endpoint: .pokemon,queryItems: queryItems )
        }
        
        
        networkManager.execute(request, expecting: PokemonListResponse.self, completion: completion)
    }
    
    
}
