//
//  PokemonStatsCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import Foundation
final class PokemonStatsCollectionViewCellViewModel {
    
    let label : String
    let value: String
    
    
    init(label: String, value: String) {
        self.label = label
        self.value = value
    }
}
