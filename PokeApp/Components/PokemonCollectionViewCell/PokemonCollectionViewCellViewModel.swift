//
//  PokemonCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 1/09/23.
//

import Foundation

class PokemonCollectionViewCellViewModel: Hashable {

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
        
        ImageLoader.shared.downloadImage(url, completion: completion)
        
    }
    
    // MARK: - Hash
    func hash(into hasher: inout Hasher) {
        hasher.combine(pokemonName)
        hasher.combine(pokemonImageUrl)
    }
    
    static func == (lhs: PokemonCollectionViewCellViewModel, rhs: PokemonCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
