//
//  Pokemon.swift
//  PokeApp
//
//  Created by Juan Carlos Hernandez Castillo on 6/09/23.
//

import Foundation

struct Pokemon: Codable {
    let id: Int
    let name: String
    let height: Int // decimeter
    let weight: Int // hectograms
    let stats: [Stat]
    let types: [`Type`]
    
}

extension Pokemon {
    private static let imagesStringUrl = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/"
    
    var imageUrl: URL? {
        
        let pokemonImageStringUrl = Pokemon.imagesStringUrl + String(self.id) + ".png"
        return URL(string: pokemonImageStringUrl)
        
    }
    
    var imageShinyUrl: URL? {
        let pokemonImageStringUrl = Pokemon.imagesStringUrl + "shiny/" + String(self.id) + ".png"
        return URL(string: pokemonImageStringUrl)
    }
}
