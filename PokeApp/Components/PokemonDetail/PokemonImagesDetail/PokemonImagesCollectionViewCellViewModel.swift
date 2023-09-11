//
//  PokemonImagesCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import Foundation

final class PokemonImagesCollectionViewCellViewModel {
    private let imageURL: URL?
    public let pokemonForm: PokemonForm
    
    init(imageURL: URL?, pokemonForm: PokemonForm) {
        self.imageURL = imageURL
        self.pokemonForm = pokemonForm
    }
    
    enum PokemonForm {
        case shiny
        case normal
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard let imageURL = imageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        ImageLoader.shared.downloadImage(imageURL, completion: completion)
    }
}
