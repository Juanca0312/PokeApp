//
//  PokemonCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 1/09/23.
//

import Foundation

class PokemonCollectionViewCellViewModel {
    public let pokemonName: String
    private let pokemonImageUrl: URL?
    
    init(pokemonName: String, pokemonImageUrl: URL?) {
        self.pokemonName = pokemonName
        self.pokemonImageUrl = pokemonImageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let url = pokemonImageUrl else  {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            
            completion(.success(data))
        }
        task.resume()
        
    }
}
