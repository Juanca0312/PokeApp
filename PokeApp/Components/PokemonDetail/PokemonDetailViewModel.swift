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
    @Published var isLoading : Bool?

    
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
        guard let pokemonObservable = pokemonObservable else { return }
        sections = [
            .images(viewModels: [
                .init(imageURL: pokemonObservable.imageUrl, pokemonForm: .normal),
                .init(imageURL: pokemonObservable.imageShinyUrl, pokemonForm: .shiny)
            ]),
            .info(viewModels: [
                .init(type: .height, value: String(pokemonObservable.heightMeters)),
                .init(type: .types, types: pokemonObservable.types),
                .init(type: .weight, value: String(pokemonObservable.weightKGrams))
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
        
        self.isLoading = true 
        
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
            
            self.isLoading = false
        }
    }
}
