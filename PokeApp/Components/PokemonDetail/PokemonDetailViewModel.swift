//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import Foundation
import Combine

final class PokemonDetailViewModel {
    let pokemon: PokemonListItem
    private let pokemonService: PokemonServiceProtocol
    
    @Published var pokemonObservable: Pokemon?
    
    enum SectionType {
        case images(viewModels: [PokemonImagesCollectionViewCellViewModel])
        case info(viewModels: [PokemonInfoCollectionViewCellViewModel])
        case stats(viewModels: [PokemonStatsCollectionViewCellViewModel])
        case damageRelations(viewModels: [PokemonDamageRelationsCollectionViewCellViewModel])
    }
    
    public var sections : [SectionType] = []
    
    init(pokemon: PokemonListItem, pokemonService: PokemonServiceProtocol = PokemonService()) {
        self.pokemon = pokemon
        self.pokemonService = pokemonService
    }
    
    public func setUpSections() {
        sections = [
            .images(viewModels: [
                .init(imageURL: pokemonObservable?.imageUrl),
                .init(imageURL: pokemonObservable?.imageShinyUrl)
            ]),
            .info(viewModels: [
                .init(),
                .init(),
                .init()
            ]),
            .stats(viewModels: [
                .init(),
                .init(),
                .init(),
                .init(),
                .init(),
                .init()
            ]),
            .damageRelations(viewModels: [
                .init(),
                .init(),
            ])
        ]
    }
    
    public var title: String {
        pokemon.name.capitalized
    }
    
    public func fetchPokemon() {
        guard let intId = Int(pokemon.id) else {
            fatalError("id not found")
        }
        pokemonService.getPokemonById(id: intId) { [weak self] result in
            
            guard let self = self else { return }
            switch result {
            case .success(let result):
                pokemonObservable = result
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
