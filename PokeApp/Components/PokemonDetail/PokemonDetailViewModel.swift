//
//  PokemonDetailViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 3/09/23.
//

import Foundation

final class PokemonDetailViewModel {
    let pokemon: PokemonListItem
    private let pokemonService: PokemonServiceProtocol
    
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
        setUpSections()
    }
    
    private func setUpSections() {
        sections = [
            .images(viewModels: [
                .init(),
                .init()
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
        pokemonService.getPokemonById(id: intId) { resul in
            switch resul {
            case .success(let result):
                print("resultados")
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
}
