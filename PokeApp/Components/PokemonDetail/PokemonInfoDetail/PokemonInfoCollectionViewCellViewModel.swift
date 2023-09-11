//
//  PokemonInfoCollectionViewCellViewModel.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 8/09/23.
//

import Foundation
final class PokemonInfoCollectionViewCellViewModel {
    public let type: InfoType
    private let value: String?
    private let pokemonTypes: [`Type`]?
    
    
    enum InfoType: String {
        case weight
        case types
        case height
    }
    
    /// Display value with color if is 'Type'
    var displayValue: NSMutableAttributedString {
        switch type {
        case .weight:
            let attributedText = NSMutableAttributedString(string: "\(value!) kg")
            return attributedText
        case .types:
            guard let pokemonTypes = pokemonTypes else { fatalError() }
            
            let typesArray = pokemonTypes.map { $0.type.name.rawValue }
            let typesString = typesArray.joined(separator: " / ")
            let attributedText = NSMutableAttributedString(string: typesString)
            
            for type in pokemonTypes {
                let range = (attributedText.string as NSString).range(of: type.type.name.rawValue)
                attributedText.addAttribute(.foregroundColor, value: type.type.name.typeColor, range: range)

            }
            
            return attributedText
        case .height:
            let attributedText = NSMutableAttributedString(string: "\(value!) cm")
            return attributedText
        }
    }
    
    /// Init for weight and value cases
    /// - Parameters:
    ///   - type: type of cell
    ///   - value: value of cell
    init(type: InfoType, value: String) {
        self.type = type
        self.value = value
        self.pokemonTypes = nil
    }
    
    /// Init for types value case
    /// - Parameters:
    ///   - type: type of cell
    ///   - pokemonTypes: list of pokemon types to display on cell
    init(type: InfoType, types pokemonTypes: [`Type`]) {
        self.type = type
        self.value = nil
        self.pokemonTypes = pokemonTypes
    }
    
}
